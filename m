Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030909AbWKOTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030909AbWKOTNW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030901AbWKOTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:13:22 -0500
Received: from bay0-omc2-s24.bay0.hotmail.com ([65.54.246.160]:58131 "EHLO
	bay0-omc2-s24.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1030909AbWKOTNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:13:21 -0500
Message-ID: <BAY20-F9CB5C5B7B494CDAD29493D8EA0@phx.gbl>
X-Originating-IP: [80.178.1.111]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, weissg@vienna.at
Subject: [PATCH 2.6.19-rc5] ohci: replace kmalloc+memset with kzalloc
Date: Wed, 15 Nov 2006 21:13:15 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 15 Nov 2006 19:13:20.0396 (UTC) FILETIME=[1CEC34C0:01C708EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch replaced kmalloc+memset with kzalloc in the ohci source.

Regards
Yan Burman

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.com/

