Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751988AbWG1Jkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbWG1Jkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 05:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWG1Jkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 05:40:42 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:36587 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751988AbWG1Jkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 05:40:42 -0400
Message-ID: <44C97913.6000607@namesys.com>
Date: Thu, 27 Jul 2006 20:40:19 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Grzegorz Kulewski <kangur@polcom.net>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org> <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com> <44C44622.9050504@namesys.com> <20060724085455.GD24299@merlin.emma.line.org> <44C4813E.2030907@namesys.com> <20060726131709.GB5270@ucw.cz> <Pine.LNX.4.63.0607271732010.8976@alpha.polcom.net> <20060727172852.GA11321@merlin.emma.line.org>
In-Reply-To: <20060727172852.GA11321@merlin.emma.line.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>I wonder what makes the hash overflow issue so complicated (other than
>differing business plans, that is) that upgrading in place isn't
>possible. Changes introduce instability, but namesys were proud of their
>regression testing - so how sustainable is their internal test suite?
>  
>
>
Never met a test suite the equal of a few million users.....

People have this image of Namesys as some large corporation that has
large resources.  We just barely are going to be able to ship reiser4,
at the cost of a LOT of financial pain.  We can't afford to go in two
directions at once.  We can add bugfixes to V3, but adding features, I
have to tell you that we ain't got the staff for both that and shipping
V4.  Our whole corporation has a budget about what most corporations
spend on two programmers.   We have 5 developers, including me, and
making little bits of money is a constant distraction from the main work.

Hans
