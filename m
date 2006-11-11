Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946066AbWKKSbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946066AbWKKSbz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424600AbWKKSbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:31:55 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:54710 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1424599AbWKKSby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:31:54 -0500
Date: Sat, 11 Nov 2006 18:31:49 +0000 (GMT)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: Benoit Boissinot <bboissin@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOM in 2.6.19-rc*
In-Reply-To: <40f323d00611110923v6f094926jf2123c15a1edddc7@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611111829440.1247@sheep.housecafe.de>
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
 <40f323d00611110923v6f094926jf2123c15a1edddc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006, Benoit Boissinot wrote:
> On 11/11/06, Christian Kujau <evil@g-house.de> wrote:
> Just a thought, do you have a swap activated ? (there is a bug in edgy
> where the swap isn't mounted)

ah, forgot to mention this: yes, swap was activated (~300 MB swapfile, 
box has 1GB RAM) but I disabled it after the 2nd incident because I 
thought the machine would recover faster from OOM when no swap to fill 
up was available...didn't help much though :(

Thanks,
Christan.
-- 
BOFH excuse #142:

new guy cross-connected phone lines with ac power bus.
