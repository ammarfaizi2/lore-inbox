Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270543AbTGPIgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270460AbTGPIeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:34:18 -0400
Received: from p15108950.pureserver.info ([217.160.128.7]:54167 "EHLO
	pluto.schiffbauer.net") by vger.kernel.org with ESMTP
	id S270420AbTGPIdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:33:13 -0400
Date: Wed, 16 Jul 2003 10:43:14 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: linux-kernel@vger.kernel.org
Subject: Re: modules problems with 2.6.0
Message-ID: <20030716084314.GB31074@lisa>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F147B8F.5000103@mail.usfq.edu.ec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F147B8F.5000103@mail.usfq.edu.ec>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.20-hpt i686
X-Editor: vim 6.1.018-1
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fernando Sanchez schrieb am 16.07.03 um 00:09 Uhr:
> Hi,
> 
> I've been trying to get 2.6.0 to work, I've enabled modules support, but 
> I get this error on my logs:
> 
> Jul 15 15:38:36 Darakemba kernel: No module symbols loaded - kernel 
> modules not enabled.
> 
> Is there any thing like a new modutils that should be used with 2.6.x 
> family?
> 
> The kernel does boot, but not having any modules I can't do much, and 
> also, I never get to really see the messages on screen, on logs I have 
> this line:
> 
> Jul 15 15:38:36 Darakemba kernel: Video mode to be used for restore is ffff
> 
> What does it mean?
> 
> I disabled all the framebuffer things so I can just use vga, on lilo, 
> vga mode is set to normal, but still can't see anything.
> 
> 

Fernando,


read http://www.codemonkey.org.uk/post-halloween-2.5.txt
(but hsving DNS problems from germany right now)

-Marc

-- 
BUGS My programs  never  have  bugs.  They  just  develop  random
     features.  If you discover such a feature and you want it to
     be removed: please send an email to bug at links2linux.de 
