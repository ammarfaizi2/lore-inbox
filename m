Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVBBXfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVBBXfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVBBXcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:32:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:63437 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262717AbVBBX3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:29:21 -0500
Date: Wed, 2 Feb 2005 15:29:09 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050202232909.GA14607@kroah.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain> <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 03:23:30PM -0800, Patrick Mochel wrote:
> 
> What is wrong with creating a (GPL'd) abstraction layer that exports
> symbols to the proprietary modules?

Ick, no!

Please consult with a lawyer before trying this.  I know a lot of them
consider doing this just as forbidden as marking your module
MODULE_LICENSE("GPL"); when it really isn't.

thanks,

greg k-h
