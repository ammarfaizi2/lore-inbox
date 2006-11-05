Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWKEKQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWKEKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 05:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWKEKQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 05:16:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14227 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932621AbWKEKQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 05:16:27 -0500
Subject: Re: How do I know whether a specific driver being used?
From: Arjan van de Ven <arjan@infradead.org>
To: xp newbie <xp_newbie@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061105033026.53019.qmail@web38401.mail.mud.yahoo.com>
References: <20061105033026.53019.qmail@web38401.mail.mud.yahoo.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 05 Nov 2006 11:16:25 +0100
Message-Id: <1162721785.3160.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-04 at 19:30 -0800, xp newbie wrote:
> I am using an Ubuntu system with kernel 2.6.15-27-686.
> 
> I am trying to find out whether I need to compile
> myself a driver for my Promise FastTrack 378
> controller as described here:
> 
> http://www.linuxquestions.org/questions/showthread.php?t=362780

Hi,

no you don't need those drivers; the linux kernel and the dmraid
userspace program have everything you need, no need to add weird
external (and sometimes proprietary) drivers to support your
software/bios raid

Greetings,
   Arjan van de Ven

