Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992755AbWJTWzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992755AbWJTWzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992753AbWJTWzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:55:15 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:61078 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S2992756AbWJTWzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:55:14 -0400
Message-ID: <453953EC.3000407@bizmail.com.au>
Date: Sat, 21 Oct 2006 08:55:40 +1000
From: Jim <yh@bizmail.com.au>
Reply-To: yh@bizmail.com.au
Organization: yh@bizmail.com.au, yhus@users.sf.net;yh@paradise.net.nz;yhus@users.sf.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel internal built in module loading order
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Does the kernel load internal built in modules (obj-y) in a certain 
order, or in a random order? Does the kernel internal module loading 
based on a configuration file?

I am running an ARM system, is there a way to delay the Ethernet module 
loading until some other internal modules are loaded?

Thank you.

Jim
