Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTKRLak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 06:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTKRLak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 06:30:40 -0500
Received: from main.gmane.org ([80.91.224.249]:13719 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262569AbTKRLaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 06:30:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: Re: Smartmedia 2.6.0-test9 problem.
Date: Tue, 18 Nov 2003 11:31:39 -0000
Message-ID: <bpcvsr$1bp$1@sea.gmane.org>
References: <bpcumv$v22$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/sda1    /mnt/smedia    vfat    rw,user,noauto    0,0

There's a typo in the above - its actually;
/dev/sda1    /mnt/smedia    vfat    rw,user,noauto    0    0

--
Patrick



