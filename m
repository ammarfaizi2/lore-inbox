Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVKFAaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVKFAaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVKFAaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:30:22 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:5405 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S932231AbVKFAaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:30:21 -0500
Date: Sun, 6 Nov 2005 01:30:19 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
Message-ID: <20051106003019.GA19508@hansmi.ch>
References: <20051105234938.GA18608@hansmi.ch> <436D4A36.70606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436D4A36.70606@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does booting with video=xxxfb:1152x768M@60 work?  If it does, I would prefer
> that we avoid adding more entries to the global mode database.

It boots but the picture is stretched over the display. That's what I
first tried, too, but only adding the mode definition fixed it.

Greets,
Michael
