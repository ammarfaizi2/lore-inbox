Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBXKJF>; Sat, 24 Feb 2001 05:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129119AbRBXKIy>; Sat, 24 Feb 2001 05:08:54 -0500
Received: from [62.122.72.237] ([62.122.72.237]:9476 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S129093AbRBXKIo>; Sat, 24 Feb 2001 05:08:44 -0500
To: linux-kernel@vger.kernel.org
Cc: peter@cadcamlab.org
Subject: Re: unable to link 2.4.2
In-Reply-To: <87pug8eaf3.fsf@penny.ik5pvx.ampr.org>
	<20010224034601.C11263@cadcamlab.org>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 24 Feb 2001 11:10:51 +0100
In-Reply-To: <20010224034601.C11263@cadcamlab.org>
Message-ID: <87itm0l7bo.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Peter" == Peter Samuelson <peter@cadcamlab.org> writes:

    > [Pierfrancesco Caci]
    >> Hi there, can someone please tell me what's going wrong with my
    >> compilation of 2.4.2 ?

    > Change '-oformat' to '--oformat' 4 places in arch/i386/boot/Makefile.

    >> Binutils               2.10.91.0.2

    > This version of binutils no longer accepts the old 'ld -oformat' form
    > of '--oformat'.

    > Peter

Thanks, almost at the same time as reading your reply, I spotted a
similar suggestion in a debian configuration message....
Nice to see helpful people are so frequent here, anyway.

Ciao

Pf




-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.1 #1 Sat Feb 3 20:43:54 CET 2001 i686 unknown
