Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRAGLHx>; Sun, 7 Jan 2001 06:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130335AbRAGLHm>; Sun, 7 Jan 2001 06:07:42 -0500
Received: from [213.166.15.20] ([213.166.15.20]:29971 "EHLO mail.fsbdial.co.uk")
	by vger.kernel.org with ESMTP id <S130162AbRAGLHf>;
	Sun, 7 Jan 2001 06:07:35 -0500
Message-ID: <3A5494F3.A8853212@FreeNet.co.uk>
Date: Thu, 04 Jan 2001 15:21:23 +0000
From: Sid Boyce <sidb@FreeNet.co.uk>
Reply-To: sidb@FreeNet.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: prerelease-ac5 make dep error
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It was 3.78.1, Documentation/Changes says 3.77, upgraded to 3.79.1 and
it's AOK.
Thanks and Regards
Sid.
=================================================
Keith Owens wrote:
On Thu, 04 Jan 2001 10:27:59 +0000, 
Sid Boyce <sidb@FreeNet.co.uk> wrote: 
> Just seen this on UP kernel build..... 
>/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' 
>references itself (eventually). Stop. 

What does make --version report? 
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop.. Tel. 44-121 422 0375

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
