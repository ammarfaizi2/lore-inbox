Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWD1Lq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWD1Lq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWD1Lq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:46:29 -0400
Received: from horus.tecnoera.com ([200.24.235.2]:27316 "EHLO
	horus.tecnoera.com") by vger.kernel.org with ESMTP id S965207AbWD1Lq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:46:28 -0400
Message-ID: <44520085.3030909@tecnoera.com>
Date: Fri, 28 Apr 2006 07:46:13 -0400
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux/iptables + smp question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I've been using an old single processor / linux 2.4 iptables based 
firewall for a few years.

Now it's time to upgrade that machine, so, I am wondering, would it be 
of real benefit if I put a two-processor system for a firewall? This 
machine is going to have 4 NICs, it's going to make routing (lots of 
routes), and firewall (iptables). I don't know if these kind of tasks 
take advantage from a multiple-processor architecture. Please enlighten 
me :)

Thank you!

