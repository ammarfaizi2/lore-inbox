Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWH0G45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWH0G45 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 02:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWH0G45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 02:56:57 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:57510 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S1750788AbWH0G44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 02:56:56 -0400
Message-ID: <44F141FA.8050408@adelphia.net>
Date: Sun, 27 Aug 2006 01:55:54 -0500
From: "Jasper O'neal Hartline" <jasperhartline@adelphia.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, tori@unhappy.mine.nu
Subject: dmfe and tulip modules list duplicate PCI IDs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dmfe and tulip modules list both the 0x1282/0x9100 and 0x1282/0x9102 
PCI ids

This is known to cause ifup failures with a CNET PRO200 PCI eth0 card.
Thanks.

J. Hartline
