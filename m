Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWGES2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWGES2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWGES2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:28:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35227
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964959AbWGES2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:28:37 -0400
Date: Wed, 05 Jul 2006 11:29:01 -0700 (PDT)
Message-Id: <20060705.112901.104047882.davem@davemloft.net>
To: greg@kroah.com
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [RFC] change netdevice to use struct device instead of struct
 class_device
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060704223101.GA25275@kroah.com>
References: <20060703231610.GA18352@kroah.com>
	<20060703.185747.74753207.davem@davemloft.net>
	<20060704223101.GA25275@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Tue, 4 Jul 2006 15:31:01 -0700

> Do you mind if I keep this in my tree, due to the dependancies on the
> other driver core changes?

Feel free.
