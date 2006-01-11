Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWAKUTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWAKUTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWAKUTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:19:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44435
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751190AbWAKUTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:19:14 -0500
Date: Wed, 11 Jan 2006 12:19:14 -0800 (PST)
Message-Id: <20060111.121914.44668958.davem@davemloft.net>
To: drepper@redhat.com
Cc: jengelh@linux01.gwdg.de, jakub@redhat.com, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43C5522C.6080306@redhat.com>
References: <20060111094854.GK7768@devserv.devel.redhat.com>
	<Pine.LNX.4.61.0601111935340.19259@yvahk01.tjqt.qr>
	<43C5522C.6080306@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Wed, 11 Jan 2006 10:45:00 -0800

> And just to be complete: I sent DaveM the correct line for that file in
> question, I just C&Ped the wrong line my scripts produced.  The mail
> seem not to make it to lkml.  In fact, none of my mail originated from
> the gmail account ever made it.  I don't know what filter doesn't like me.

This one:

m/^Content-Transfer-Encoding:\s*base64/i
