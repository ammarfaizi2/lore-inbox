Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVJNNvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVJNNvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 09:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVJNNvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 09:51:42 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:51660 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750736AbVJNNvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 09:51:42 -0400
Message-Id: <6.1.1.1.2.20051014154955.026f38e0@192.168.6.2>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Fri, 14 Oct 2005 15:50:33 +0200
To: linux-kernel@vger.kernel.org
From: Roger While <simrw@sim-basis.de>
Subject: 2.6 - SCSI Config parameter always set ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-MDRemoteIP: 192.168.6.50
X-Return-Path: simrw@sim-basis.de
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-ID: E1HZVOZrZe0mK5fjnmJVcqH5kQlVYRcAgHs3vJdit8t-0UWJGmZtwC@t-dialin.net
X-TOI-MSGID: 187ab2ea-4c46-497c-b976-89b951107edc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SCSI_QLA2XXX=y

It seems as though this is always set with no method
of unsetting it.
Is this intentional ?

It's been like this since at least 2.6.11 up to current 2.6.14rc4.

Roger While



