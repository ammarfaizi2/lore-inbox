Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269824AbTGOWQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269826AbTGOWQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:16:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:3307 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269824AbTGOWP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:15:57 -0400
Date: Tue, 15 Jul 2003 15:30:11 -0700
From: Greg KH <greg@kroah.com>
To: Fernando Sanchez <fsanchez@mail.usfq.edu.ec>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modules problems with 2.6.0
Message-ID: <20030715223010.GA6372@kroah.com>
References: <3F147B8F.5000103@mail.usfq.edu.ec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F147B8F.5000103@mail.usfq.edu.ec>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 05:09:19PM -0500, Fernando Sanchez wrote:
> Hi,
> 
> I've been trying to get 2.6.0 to work, I've enabled modules support, but 
> I get this error on my logs:
> 
> Jul 15 15:38:36 Darakemba kernel: No module symbols loaded - kernel 
> modules not enabled.
> 
> Is there any thing like a new modutils that should be used with 2.6.x 
> family?

Yes there is.  Please read the Documentation/Changes file for this info.

(hint, you need to get the module-init-tools package.)

Good luck,

greg k-h
