Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbQKPJyk>; Thu, 16 Nov 2000 04:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKPJya>; Thu, 16 Nov 2000 04:54:30 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23044 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129718AbQKPJyO>;
	Thu, 16 Nov 2000 04:54:14 -0500
To: "Andreas S. Kerber" <ask@ag-trek.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large File Support
In-Reply-To: <20001116084437.A14842@kira.in.ag-trek.de>
	<u866lomitz.fsf@gromit.rhein-neckar.de>
From: Andreas Jaeger <aj@suse.de>
Date: 16 Nov 2000 10:23:31 +0100
In-Reply-To: <u866lomitz.fsf@gromit.rhein-neckar.de>
Message-ID: <u8g0ksl17w.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andreas Jaeger writes:

>>>>> Andreas S Kerber writes:
>> We need to handle files which are about 10GB large.
>> Is there any way to do this with Linux? Some pointers would be nice.

 > Yes, with recent 2.4 kernels or a patched 2.2 kernel - and a
 > recompiled glibc.  For details check:

Upps, there was a typo in the URL - please try this one - or go to it
via my homepage:
http://www.suse.de/~aj/linux_lfs.html

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
