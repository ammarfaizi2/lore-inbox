Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262333AbRENLNQ>; Mon, 14 May 2001 07:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262337AbRENLNG>; Mon, 14 May 2001 07:13:06 -0400
Received: from babel.spoiled.org ([212.84.234.227]:52394 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S262333AbRENLMx>;
	Mon, 14 May 2001 07:12:53 -0400
Date: 14 May 2001 11:12:51 -0000
Message-ID: <20010514111251.32556.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: r.verhees@chello.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c900 card and kernel 2.4.3 <
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <20010504203107.DVQ23593.amsmta01-svc@[192.168.2.1]>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r.verhees@chello.nl wrote:
> Hi there,
> 
> when i install kernel 2.4.3 or higher on my slackware
> system the card (3c900) gets detected but doesn't do
> anything, i also get the line "using NWAY 8" or something
> like that (had to switch back to 2.4.2 to type e-mail)
> wondered if anyone else had this problem and if there's
> some way to solve it?

Hi Ronnie,

did you receive any answer?

Do you use 10Base2 (aka cheaper net)?
I do and after upgrading to 2.4.3 (I think) I had to force the driver to
use the BNC connector though the card was configured (via the little config
program supplied by 3com) to always use the BNC connector...
This way I lost several hours to figure out why it wasn't working anymore and
to discover that I have to build it as a module instead of having it compiled
into the kernel because I couldn't make it work with kernel options - only
with driver options...
Any suggestions?

Juri

-- 
Juri Haberland  <juri@koschikode.com> 

