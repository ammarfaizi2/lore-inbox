Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291102AbSCRSIA>; Mon, 18 Mar 2002 13:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291148AbSCRSHu>; Mon, 18 Mar 2002 13:07:50 -0500
Received: from colino.net ([62.212.100.143]:11774 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id <S291102AbSCRSHc>;
	Mon, 18 Mar 2002 13:07:32 -0500
Date: Mon, 18 Mar 2002 19:07:28 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: Re: question about 2.4.18 and ext3
Message-Id: <20020318190728.3eafddbe.colin@colino.net>
In-Reply-To: <20020318172756.GK2254@matchmail.com>
Organization: Colino Computing
X-Mailer: Sylpheed version 0.7.4claws21 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002 09:27:56 -0800 Mike Fedyk <mfedyk@matchmail.com>
wrote:

> > Is there a problem with ext3 on 2.3.18 ?

s/3/4/, sorry.

> You should try the ppc kernel available from http://www.penguinppc.org/
> 
> Has ppc been merged enough to use the stock kernel now?

I saw here that it was widely merged :

http://www.imaclinux.net/php/imaclinux.php3?subject=kernel

"Finish of the PPC merge into kernel 2.4.18 
 Posted by Olivier Reisch on Friday January 11th, 2002 12:11:39 PM
 Linux 2.4.18-pre3 is available and with it, the larger PPC merge with 
2.4.18 has been accomplished. The official kernel.org sources are now 
almost up to par with the official stable PPC tree. Thus, it should 
compile fine on most PPC machines and include the latest features."

So I used a stock kernel. In fact it runs very well apart from these ext3
problems.-- 
Colin
panic("Lucy in the sky....");
    2.2.19 linux/arch/sparc64/kernel/starfire.c
