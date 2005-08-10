Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVHJG1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVHJG1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 02:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHJG1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 02:27:52 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56548 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965016AbVHJG1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 02:27:52 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: maneesh@in.ibm.com
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: 2.6.13-rc4 use after free in class_device_attr_show 
In-reply-to: Your message of "Tue, 02 Aug 2005 13:34:22 +0530."
             <20050802080422.GA32556@in.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Aug 2005 16:26:51 +1000
Message-ID: <15242.1123655211@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, the intermittent free after use in sysfs is still there in
2.6.13-rc6.

