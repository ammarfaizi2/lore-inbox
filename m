Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVFJJAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVFJJAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 05:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVFJJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 05:00:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1756 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262519AbVFJJAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 05:00:44 -0400
Date: Fri, 10 Jun 2005 11:00:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Ketrenos <jketreno@linux.intel.com>,
       "David S. Miller" <davem@davemloft.net>, vda@ilport.com.ua,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
Message-ID: <20050610090022.GF4173@elf.ucw.cz>
References: <200506090909.55889.vda@ilport.com.ua> <20050608.231657.59660080.davem@davemloft.net> <20050609104205.GD3169@elf.ucw.cz> <20050609.125324.88476545.davem@davemloft.net> <42A8AE2A.4080104@linux.intel.com> <42A8F758.2060008@pobox.com> <42A8FF03.3010508@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A8FF03.3010508@linuxwireless.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OK. I understand the point and I totally agree with this. We really want 
> the adapter to just do what the user or profiles ask the adapter to do. 
> Yes, in an ideal world.
> 
> Let's talk about easyness. These adapters are in laptops. You don't want 
> to type a lot of stop everytime you move from access points, reboots
> and 

We are not trying to make it hard to the users. Lets do the right
thing in kernel, and let userspace make it easy.
								Pavel
