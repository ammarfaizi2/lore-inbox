Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266847AbUGVJvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266847AbUGVJvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266848AbUGVJvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:51:18 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:38881 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S266847AbUGVJvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:51:15 -0400
Message-ID: <1090489874.40ff8e1226ad0@imp6-q.free.fr>
Date: Thu, 22 Jul 2004 11:51:14 +0200
From: christophe.varoqui@free.fr
To: linux-kernel@vger.kernel.org
Subject: [Q] claimed block devices
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.4
X-Originating-IP: 171.16.4.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

does somebody know how a userspace C-proggy can detect if a block device is
claimed  ? Creating a device map over such devices will fail, so better not to
try.

regards,
cvaroqui

--
