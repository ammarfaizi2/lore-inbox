Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFOQhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFOQhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 12:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVFOQhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 12:37:25 -0400
Received: from animx.eu.org ([216.98.75.249]:20391 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261213AbVFOQhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 12:37:17 -0400
Date: Wed, 15 Jun 2005 12:53:58 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Problem found: kaweth fails to work on 2.6.12-rc[456]
Message-ID: <20050615165358.GA10993@animx.eu.org>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050612004136.GA8107@animx.eu.org> <200506150829.52765.oliver@neukum.org> <20050615113159.GA10188@animx.eu.org> <200506151330.02486.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506151330.02486.oliver@neukum.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> > I meant I didn't know the name to number translation.
> 
> Sorry, ENOENT.

Ok.

> > For the next tests, I think it would be best to remove the 3 printks I added
> > to show beginning, u->status, and ending.  Spews too much stuff =)
> 
> Please do so and try removing and reattaching the cable.

I removed the printks that were spewing lines that are now no longer useful. 
I left the ones that are in the block for the if statement.   There is no
change when I unplug and replug the ethernet cable.  The link light on the
device does go off.  Is it possible that the hardware cannot report link
state?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
