Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272661AbTG3EDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 00:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272680AbTG3EDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 00:03:39 -0400
Received: from postal.sac2.fastsearch.net ([66.77.74.41]:36613 "EHLO
	postal.sac2.fastsearch.net") by vger.kernel.org with ESMTP
	id S272661AbTG3EDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 00:03:38 -0400
Message-ID: <3F2743F7.7030302@overture.com>
Date: Tue, 29 Jul 2003 21:05:11 -0700
From: Stacy Redmond <stacy.redmond@overture.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 kernel hangs during uncompress
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to run the 2.4.20 kernel on a Dell 2650, upgrading from 
2.4.18-5.  When I go to reboot the machine with the new kernel it comes 
up and says uncompressing kernel and then hangs.  
Dell 2650 1x2.0MHz 4GB Ram
Linux 7.3 running 2.4.18-5
Building a Vanilla RedHat kernel with HighMem patch 2.4.20


