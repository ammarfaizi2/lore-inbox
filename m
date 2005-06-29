Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbVF2Rxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbVF2Rxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVF2RwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:52:25 -0400
Received: from po2.wam.umd.edu ([128.8.10.164]:12531 "EHLO po2.wam.umd.edu")
	by vger.kernel.org with ESMTP id S262367AbVF2RwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:52:06 -0400
Date: Wed, 29 Jun 2005 13:52:00 -0400 (EDT)
From: Patrick David Jenkins <patjenk@wam.umd.edu>
To: linux-kernel@vger.kernel.org
Subject: ip multipath cached routing status
Message-ID: <Pine.GSO.4.61.0506291348190.8955@rac1.wam.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know the current status of network multipath caching? I have 
tried to get in contact with Einar Lueck and David Miller who are the last 
two programmers to work on that code and have been unsuccessful.

The framework for this feature appears to be present but I cannot get it 
to function. I have tried adding the multiple routes the way it is done 
with load balancing but the kernel doesn't seem to be able to use both 
routes from the routing cache. In fact, when there are multiple routes 
networking does not work. Furthermore, I am unable to see the presence of 
multiple routes from printk's I have included.

I am not subscribed to this list so please cc patjenk@wam.umd.edu if you 
want to reply.

Thanks
Pat Jenkins
