Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbTL2TMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTL2TMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:12:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63617 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265398AbTL2TKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:10:03 -0500
Message-ID: <3FF07BF3.2090500@pobox.com>
Date: Mon, 29 Dec 2003 14:09:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Muli Ben-Yehuda <mulix@mulix.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
References: <20031229183846.GI13481@actcom.co.il> <Pine.LNX.4.58.0312291049020.2113@home.osdl.org> <20031229185627.GJ13481@actcom.co.il>
In-Reply-To: <20031229185627.GJ13481@actcom.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> You're 100% right. Internally, the patch I sent is composed of 30
> different patches. The reason I didn't seperate it into two patches is
> that the changes were interleaved and inter-dependant and seperating
> them was a b*tch. If Andrew wishes to include it in -mm or you wish to
> include it in -vanilla and would like it in two seperate patches, I'll
> go back and redo it that way. 


Thirty separate patches is OK.

We have scripts to handle "patchbombs".

	Jeff



