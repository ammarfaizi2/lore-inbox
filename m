Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271054AbTGPLXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTGPLX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:23:29 -0400
Received: from bgp01116707bgs.westln01.mi.comcast.net ([68.42.104.61]:11288
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id S271054AbTGPLX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:23:26 -0400
Message-ID: <3F152FF7.5000309@blackmagik.dynup.net>
Date: Wed, 16 Jul 2003 06:59:03 -0400
From: Eric Blade <eblade@blackmagik.dynup.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: petero2@telia.com
CC: linux-kernel@vger.kernel.org
Subject: Re: radeonfb patch for 2.4.22...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a small problem with radeonfb in 2.4.22-pre5 (+manually created radeonfb.h file). During boot, when the console is switched over to
> the frame buffer device, the screen becomes corrupted. Mostly by white squares in a grid pattern and some squares with other colors. Between
> the squares, normal characters can be seen, but each character is duplicated. 



This has been happening to me on my Radeon and on my Voodoo 3 for as long as there has been framebuffers and they have in fact compiled and worked.  I thought this was normal?



-- 
----BEGIN GEEK CODE BLOCK----
Version: 3.1
GB/CS/MC/MU/O @d+ s:- a- C++++ UL++++  !P  L+++ !E W+++ !N !o K? w--- @O++ !M !V PS+ PE- Y PGP- @t 5? X R tv-- b- DI++ D++ G e* h* r  y+ 
----END GEEK CODE BLOCK----




