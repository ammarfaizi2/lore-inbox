Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTIXAj3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTIXAj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:39:29 -0400
Received: from web20704.mail.yahoo.com ([216.136.226.177]:31882 "HELO
	web20704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261159AbTIXAj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:39:28 -0400
Message-ID: <20030924003922.73492.qmail@web20704.mail.yahoo.com>
Date: Tue, 23 Sep 2003 17:39:22 -0700 (PDT)
From: Binny Gill <kernelwise@yahoo.com>
Subject: Multiple TCP connections serving the same NFS mount?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone seen or tried an NFS client which uses multiple parallel TCP connections for a single
mount
 to an NFS server?
This could be helpful when the server side (outside our control) has a very conservative send
window, 
but the bandwidth and latency between the two is large. 
TIA 
-b



__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
