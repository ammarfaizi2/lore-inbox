Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752458AbWAFQg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbWAFQg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbWAFQ35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:29:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10943 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752444AbWAFQ3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:47 -0500
Date: Fri, 6 Jan 2006 16:29:34 GMT
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 0/17] FRV: Permit compilation with allmodconfig
Message-Id: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patches permit the FRV arch to be mostly compiled with
allmodconfig, barring compiler errors.

