Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbTEFNvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTEFNu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:50:56 -0400
Received: from rth.ninka.net ([216.101.162.244]:43984 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263725AbTEFNut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:50:49 -0400
Subject: Re: failed assertions in 2.4.20 networking code
From: "David S. Miller" <davem@redhat.com>
To: Robert Murray <rob@mur.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030506112512.GH2388@mur.org.uk>
References: <20030506112512.GH2388@mur.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052222662.983.29.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 05:04:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 04:25, Robert Murray wrote:
> I'm getting the following messages with 2.4.20.  This machine is
> acting as a server and a router between an adsl line and my LAN.  I
> will send my iptables and tc setup if it is necessary to diagnose the
> problem.

This bug is fixed in current 2.4.x sources.

-- 
David S. Miller <davem@redhat.com>
