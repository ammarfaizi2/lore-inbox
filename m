Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTLIC04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 21:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTLIC04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 21:26:56 -0500
Received: from 65.104.119.60.ptr.us.xo.net ([65.104.119.60]:27506 "EHLO
	dns1.appliedminds.com") by vger.kernel.org with ESMTP
	id S262446AbTLIC04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 21:26:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Retriving PCI driver data from file ops
From: James Lamanna <jamesl@appliedminds.com>
Organization: Applied Minds, Inc.
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Mon, 08 Dec 2003 18:26:52 -0800
Message-ID: <oprzv6e2wi331ubk@mail.appliedminds.com>
User-Agent: Opera7.23/Win32 M2 build 3227
X-OriginalArrivalTime: 09 Dec 2003 02:26:52.0895 (UTC) FILETIME=[E856CEF0:01C3BDFB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an elegant way to retrieve a pointer registered with 
pci_set_drvdata() within an open fops function?
Or am I forced to make it a static variable?

Please CC me for I am not subscribed.

-- 
James Lamanna
