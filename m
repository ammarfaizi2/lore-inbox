Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131006AbRBCEmL>; Fri, 2 Feb 2001 23:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129096AbRBCEmA>; Fri, 2 Feb 2001 23:42:00 -0500
Received: from snoopy.apana.org.au ([202.12.87.129]:43018 "HELO
	snoopy.apana.org.au") by vger.kernel.org with SMTP
	id <S131006AbRBCElu>; Fri, 2 Feb 2001 23:41:50 -0500
To: Brian Wellington <bwelling@xbill.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
In-Reply-To: <Pine.LNX.4.21.0102022039210.12394-100000@anomaly.xbill.org>
From: Brian May <bam@snoopy.apana.org.au>
X-Home-Page: http://snoopy.apana.org.au/~bam/
Date: 03 Feb 2001 15:41:43 +1100
In-Reply-To: Brian Wellington's message of "Fri, 2 Feb 2001 20:39:41 -0800 (PST)"
Message-ID: <844rycjs3c.fsf@snoopy.apana.org.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Brian" == Brian Wellington <bwelling@xbill.org> writes:

    Brian> No, it clearly says that glibc contains its own versions of
    Brian> the net/* and scsi/* files, and that /usr/include/asm and
    Brian> /usr/include/linux should remain as they were.  Since they
    Brian> were symlinks in libc5 (which is what 'originally' seems to
    Brian> be referring to), they should still be symlinks.

Oh I see now.

Sorry for any confusion caused.
-- 
Brian May <bam@snoopy.apana.org.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
