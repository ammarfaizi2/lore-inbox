Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUAWPJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUAWPJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:09:03 -0500
Received: from mail.netbeat.de ([193.254.185.26]:28347 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S266572AbUAWPJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:09:01 -0500
Subject: Re: 2.6.2-rc1-mm2
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074870538.5122.9.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 16:08:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

With the latest pmtmr fixes, synaptics mouse driver is in sync again and
my bogomips are correct too. (synaptics had been loosing packages in -mm
releases the last weeks)

Only the radeon dri driver cannot be inserted because of an missing
symbol: 
radeon: Unknown symbol cmpxchg

Thx for the frequent releases,
Jan

