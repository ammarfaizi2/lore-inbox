Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278095AbRJKEsG>; Thu, 11 Oct 2001 00:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278096AbRJKEr4>; Thu, 11 Oct 2001 00:47:56 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:12479 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S278095AbRJKEro>; Thu, 11 Oct 2001 00:47:44 -0400
Message-ID: <3BC52499.3D60A76D@idcomm.com>
Date: Wed, 10 Oct 2001 22:48:25 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.10] README and Documentation/Changes inconsistent
In-Reply-To: <E15rJnR-0007tO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > These files state different C compiler requirements.  Which one is
> > correct?
> 
> gcc 2.95.[3,4] is probably the compiler of choice

My first attempt at this question didn't seem to make it in. On RH 7.1,
which has kgcc (2.91.66) and gcc 2.96, will it be necessary to install a
third compiler for stable 2.4.10+ compiles? Can kgcc still work for
this? I'm one of the people running XFS filesystem, and the XFS code
works well with kgcc, but it makes me nervous to think about using
anything else with XFS kernels. I would be greatly relieved if 2.91.66
remains useable throughout the 2.4.x series.

D. Stimits, stimits@idcomm.com

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
