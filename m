Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWBTQyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWBTQyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWBTQyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:54:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60615 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161033AbWBTQyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:54:19 -0500
Date: Mon, 20 Feb 2006 17:53:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael_E_Brown@Dell.com
Cc: mjg59@srcf.ucam.org, akpm@osdl.org, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060220165353.GD19156@elf.ucw.cz>
References: <35C9A9D68AB3FA4AB63692802656D9EC927875@ausx3mps303.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35C9A9D68AB3FA4AB63692802656D9EC927875@ausx3mps303.aus.amer.dell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	Matthew has shown up on the libsmbios-devel mailing list. I sent
> all the
> info needed to do a test of Dell LCD brightness control. The main thing
> left
> would be to make one utility out of the current separate, unsupported,
> test 
> utils. 
> 
> 	As for fixing i8k, I don't have the slightest clue where to
> begin. You 
> either have to split initialization with userspace to parse and send in
> the 
> correct io/magic ports to do SMI, or you have to put Dell-specific SMI
> token 
> parsing in the kernel.

What is wrong with Dell-specific SMI parsing in kernel? Is it _that_
much code?

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
