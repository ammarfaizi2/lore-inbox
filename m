Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUCLQzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUCLQzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:55:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6552 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262328AbUCLQzG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:55:06 -0500
Message-ID: <4051EB5E.3060901@pobox.com>
Date: Fri, 12 Mar 2004 11:54:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Brower <ebrower@usa.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethtool.h should use userspace-accessible types
References: <40511868.4060109@usa.net>
In-Reply-To: <40511868.4060109@usa.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Brower wrote:
> Attached is a patch to 2.4's ethtool.h to use appropriate, 
> userspace-accessible data types (__u8 and friends, rather than u8 and 
> friends).

I'm happy with u8/u16/u32, so it stays that way :)

	Jeff



