Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFORXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFORXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVFORXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:23:13 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:18465 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261235AbVFORUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:20:10 -0400
Message-ID: <42B06344.4040909@google.com>
Date: Wed, 15 Jun 2005 10:20:04 -0700
From: Hareesh Nagarajan <hareesh@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: greg@kroah.com
Subject: Porting kref to a 2.4 kernel (2.4.20 or greater)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What stumbling blocks do you think I would encounter if I wanted to port 
kref to a 2.4.xx kernel? Is kref tightly coupled with the kernel object 
infrastructure found in the 2.6.xx kernel?

Many thanks!

Hareesh
-= Engineering Intern =-
cs.uic.edu/~hnagaraj
