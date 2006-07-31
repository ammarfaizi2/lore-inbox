Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWGaQpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWGaQpq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWGaQpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:45:46 -0400
Received: from wenmed.demon.nl ([212.238.244.49]:57571 "EHLO wenmed.demon.nl")
	by vger.kernel.org with ESMTP id S1030236AbWGaQpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:45:45 -0400
Date: Mon, 31 Jul 2006 18:44:33 +0200 (CEST)
From: Rudy Zijlstra <rudy@edsons.demon.nl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
In-Reply-To: <20060731162224.GJ31121@lug-owl.de>
Message-ID: <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
 <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
 <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org>
 <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 Jul 2006, Jan-Benedict Glaw wrote:

> On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich <reiser4@blinkenlights.ch> wrote:
>> A colleague of mine happened to create a ~300gb filesystem and started
>> to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
>> to the new LUN. At about 70% the filesystem ran out of inodes; Not a
>
> So preparation work wasn't done.
>
> MfG, JBG

Of course you are right. Preparation work was not fully done. And using 
ext1 would also have been possible. I suspect you are still using ext1, 
cause with proper preparation it is perfectly usable.

Cheers,

Rudy
