Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbULBSAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbULBSAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbULBSAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:00:25 -0500
Received: from nefty.hu ([195.70.37.175]:5504 "EHLO nefty.hu")
	by vger.kernel.org with ESMTP id S261704AbULBR6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:58:54 -0500
Message-ID: <41AF57D7.10608@nefty.hu>
Date: Thu, 02 Dec 2004 18:58:47 +0100
From: Zoltan NAGY <nagyz@nefty.hu>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IPv6 bridging
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Is it possible to bridge ip tunnels (IPv6 in IPv4)? brctl gives me an 
error "Invalid argument",
and from strace it seems it misses some ioctls from kernel...

any ideas?

I need it to be able to give my UMLs a public ipv6 address.

Regrads,

Zoltan NAGY,
Software Engineer

