Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUFAR5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUFAR5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 13:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264921AbUFAR5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 13:57:36 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:8466 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264890AbUFAR5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 13:57:35 -0400
Date: Tue, 1 Jun 2004 19:57:32 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch - please comment] Support for UTF dead keys in 2.6
Message-ID: <20040601175732.GA4588@pclin040.win.tue.nl>
References: <20040529143421.GA15127@ucw.cz> <200405310809.49059.ioe-lkml@rameria.de> <20040531063149.GD268@ucw.cz> <200405311123.07203.ioe-lkml@rameria.de> <20040531120844.GA1655@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531120844.GA1655@ucw.cz>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 02:08:44PM +0200, Vojtech Pavlik wrote:

> > 	2. Does your patch also support 2 diacritics per character?
> > 	   This is a requirement for proper Vietnamese support.
> 
> No, the patch doesn't add that extension. How is that supposed to work?

The (or at least, some) support is there already. See dead2.
