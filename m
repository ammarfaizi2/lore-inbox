Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVC0Xvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVC0Xvi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVC0Xvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:51:38 -0500
Received: from main.gmane.org ([80.91.229.2]:41180 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261619AbVC0Xvc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:51:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Arioch <the_Arioch@nm.ru>
Subject: Re: [RFC] Some thoughts on device drivers and sysfs
Date: Mon, 28 Mar 2005 00:53:37 +0400
Message-ID: <d276fc$trk$2@sea.gmane.org>
References: <1111951499.3503.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 80.249.152.133
User-Agent: Mozilla Thunderbird 1.0 (X11/20050202)
X-Accept-Language: ru-ru, ru
In-Reply-To: <1111951499.3503.87.camel@localhost.localdomain>
Cc: linux-pm@lists.osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay пишет:
> I would like to propose that we create a new type of device that would
> act as the layer between physical (bus devices) and logical (class
> devices).  

why not using D-BUS to allow lowlevel drivers to expose its features to 
userspace?

