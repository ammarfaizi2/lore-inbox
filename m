Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUD1Xtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUD1Xtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUD1Xtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:49:42 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:62731 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262051AbUD1Xsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:48:43 -0400
Date: Thu, 29 Apr 2004 01:48:41 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Benoit Plessis <benoit@plessis.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input system and keycodes > 256
Message-ID: <20040428234841.GA4068@pclin040.win.tue.nl>
References: <1082938686.21842.50.camel@osiris.localnet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082938686.21842.50.camel@osiris.localnet.fr>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 02:18:07AM +0200, Benoit Plessis wrote:

> When grabbing with 'showkey -s' nothing appear
> When grabbing with 'showkey' i got keycodes like '0x00 0x82 0xd0 | 0x80
> 0x82 0xd0' (i got same keycodes when pressing mouse buttons except those
> are in 0x82 0x90 -> 0x82 0x97 range)

What version of showkey are you using?
