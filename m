Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSEERGs>; Sun, 5 May 2002 13:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSEERGr>; Sun, 5 May 2002 13:06:47 -0400
Received: from 90dyn126.com21.casema.net ([62.234.21.126]:36777 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S313194AbSEERGq>; Sun, 5 May 2002 13:06:46 -0400
Message-Id: <200205051706.TAA08782@cave.bitwizard.nl>
Subject: Re: kernel BUG at page_alloc.c:82
In-Reply-To: <200205051853.38557.linux-kernel@borntraeger.net> from "Christian
 [Borntr_ger]" at "May 5, 2002 06:53:38 pm"
To: "Christian [Borntr_ger]" <linux-kernel@borntraeger.net>
Date: Sun, 5 May 2002 19:06:48 +0200 (MEST)
CC: Fabian Svara <svara@gmx.net>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian [Borntr_ger] wrote:
> Fabian Svara wrote:
> > EIP:	0010:[<c0125183>]    Tainted: P
> 
> You have the Binary-NVIDIA Driver loaded, haven't you?

Would it be an idea to print the name of the module that (first)
tainted the kernel here? That would eliminate this "guessing".

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
