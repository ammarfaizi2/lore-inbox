Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030897AbWKOTGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030897AbWKOTGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030896AbWKOTGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:06:50 -0500
Received: from bay0-omc3-s1.bay0.hotmail.com ([65.54.246.201]:57207 "EHLO
	bay0-omc3-s1.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1030899AbWKOTGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:06:49 -0500
Message-ID: <BAY20-F17E6CB5B0A4BA6B93B0004D8EA0@phx.gbl>
X-Originating-IP: [80.178.1.111]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, mingo@redhat.com
Subject: [PATCH 2.6.19-rc5] apic: replace kmalloc+memset with kzalloc
Date: Wed, 15 Nov 2006 21:06:43 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 15 Nov 2006 19:06:48.0623 (UTC) FILETIME=[336863F0:01C708E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is a trivial patch to use kzalloc where apropriate

Regards
Yan Burman

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.com/

