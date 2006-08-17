Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWHQAuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWHQAuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHQAuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:50:11 -0400
Received: from wacom-nt10.wacom.com ([204.119.25.43]:22619 "EHLO
	wacom-nt10.wacom.com") by vger.kernel.org with ESMTP
	id S932325AbWHQAuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:50:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Removing of UTS_RELEASE in include/linux/version.h
Date: Wed, 16 Aug 2006 17:46:06 -0700
Message-ID: <6753EB6004AFF34FAA275742C104F95201753B@wacom-nt10.wacom.com>
From: "Ping Cheng" <pingc@wacom.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

I was told that the removing of UTS_RELEASE in include/linux/version.h is permanent. I use it in my configuration script to get the version numbers of different kernel build sources.  Greg k-h told me to ask you about how to properly get the kernel source version.  Do you have any suggestions?  Please don't forget to cc me directly since I am not in the mailing list.

Thanks,

Ping
