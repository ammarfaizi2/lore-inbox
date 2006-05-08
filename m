Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWEHHLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWEHHLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWEHHLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:11:20 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18977
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932356AbWEHHLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:11:20 -0400
Message-Id: <445F0B6F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Mon, 08 May 2006 09:12:15 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: GPL-only symbols issue
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

would it seem reasonable a request to detect imports of GPL-only symbols by non-GPL modules also at build time rather
than only at run time, and at least warn about such?

Thanks, Jan
