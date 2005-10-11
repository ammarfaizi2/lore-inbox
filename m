Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVJKJfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVJKJfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 05:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVJKJfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 05:35:40 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27155
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751429AbVJKJfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 05:35:40 -0400
Message-Id: <434BA3E5.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 11 Oct 2005 11:37:09 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kconfig question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there (or have there been thoughts to add) a way to specify that
multiple entities can all simultaneously be configured as modules, but
at most one of them can be built in (with both possibilities of this
still allowing or disallowing all others to be modules)?

Thanks, Jan
