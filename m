Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbVLEOmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbVLEOmE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVLEOmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:42:04 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:31653 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP id S932428AbVLEOmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:42:02 -0500
Date: Mon, 5 Dec 2005 06:41:41 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Michael Buesch <mbuesch@freenet.de>
Cc: bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Feyd <feyd@seznam.cz>
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
Message-ID: <20051205144141.GD8940@jm.kir.nu>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <200512051208.16241.mbuesch@freenet.de> <20051205141935.GC8940@jm.kir.nu> <200512051528.33146.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512051528.33146.mbuesch@freenet.de>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 03:28:32PM +0100, Michael Buesch wrote:

> Well, I do not care for drivers ignoring SoftMAC and duplicating
> the work. The question is: Why don't these drivers use SoftMAC?
> (Yeah, because it is incomplete, is the answer. :D I am talking
> about future.)

For me, the answer would have been because I had no idea about that
being worked on somewhere else. Now the answer would be more likely
"because it is not in netdev-2.6 tree with rest of ieee80211
development".

> What is so hard about a driver including ieee80211.h _and_
> ieee80211softmac.h, if it requires Software MAC? And what
> exactly is duplicated work here? SoftMAC does _not_ duplicate;
> it extends.

That is not hard as long as this work is easily available.

-- 
Jouni Malinen                                            PGP id EFC895FA
