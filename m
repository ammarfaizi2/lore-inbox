Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTJOS1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263929AbTJOS1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:27:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:53681 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263930AbTJOS0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:11 -0400
Date: Wed, 15 Oct 2003 11:10:05 -0700
From: Greg KH <greg@kroah.com>
To: "Daheriya, Adarsh" <Adarsh.Daheriya@fci.com>
Cc: "Murray, Scott" <scott_murray@stream.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Hot Swap - Resource Allocation Problem.
Message-ID: <20031015181005.GA22159@kroah.com>
References: <903E17B6FF22A24C96B4E28C2C0214D70104BDD7@sr-bng-exc01.int.tsbu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903E17B6FF22A24C96B4E28C2C0214D70104BDD7@sr-bng-exc01.int.tsbu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 09:37:35AM +0530, Daheriya, Adarsh wrote:
> hi Greg,
> 
> thanks for the reply.
> 
> i do reserve pci resources at boot time with kernel option as
> "pci_hp_reserve=8,16,16" without quotes.
> but still i am getting this problem.
> 
> is this problem coming because of mishandling of resources?

I have no idea.
