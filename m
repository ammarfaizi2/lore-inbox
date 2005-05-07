Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVEGPFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVEGPFo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 11:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVEGPFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 11:05:44 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:33434 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261514AbVEGPFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 11:05:39 -0400
Date: Sat, 7 May 2005 17:05:38 +0200
From: Sander <sander@humilis.net>
To: David Hollis <dhollis@davehollis.com>
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: ata over ethernet question
Message-ID: <20050507150538.GA800@favonius>
Reply-To: sander@humilis.net
References: <1416215015.20050504193114@dns.toxicfilms.tv> <1115236116.7761.19.camel@dhollis-lnx.sunera.com> <1104082357.20050504231722@dns.toxicfilms.tv> <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
X-Uptime: 16:09:14 up 3 min,  7 users,  load average: 0.23, 0.14, 0.06
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Hollis wrote (ao):
> There seem to be a few iSCSI implementations floating around for
> Linux, hopefully one will be added to mainline soon. Most of those
> implementations are for the client side though there is at least one
> target implementation that allows you to provide local storage to
> iSCSI clients. I don't remember the name of it or if it's still
> maintained or not.

Quite active even:

http://sourceforge.net/projects/iscsitarget/

The "Quick Guide to iSCSI on Linux" is a good starting point btw.

Also check out http://www.open-iscsi.org/ (the client, aka 'initiator').

-- 
Humilis IT Services and Solutions
http://www.humilis.net
