Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756474AbWKVSwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474AbWKVSwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756481AbWKVSwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:52:22 -0500
Received: from bay0-omc3-s38.bay0.hotmail.com ([65.54.246.238]:23992 "EHLO
	bay0-omc3-s38.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1756476AbWKVSwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:52:21 -0500
Message-ID: <BAY20-F112A1E07E12CC2817A5753D8E30@phx.gbl>
X-Originating-IP: [80.178.108.101]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, gregkh@suse.de
Subject: [PATCH 2.6.19-rc5] USB serial: replace kmalloc+memset with kzalloc
Date: Wed, 22 Nov 2006 20:52:15 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Nov 2006 18:52:21.0158 (UTC) FILETIME=[573FFC60:01C70E67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch replaces kmalloc+memset with kzalloc in the usb serial code

Regards
Yan Burman

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

