Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWFJUv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWFJUv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 16:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWFJUv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 16:51:26 -0400
Received: from main.gmane.org ([80.91.229.2]:59836 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030508AbWFJUv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 16:51:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH] pnpacpi mishandles port io ADDRESS resources
Date: Sat, 10 Jun 2006 22:51:13 +0200
Message-ID: <pan.2006.06.10.20.51.12.109916@free.fr>
References: <20060610164150.GR1651@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: linux-acpi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, 10 Jun 2006 10:41:50 -0600, Matthew Wilcox a écrit :

> 
> ACPI ADDRESSn resources can describe both memory and port io, but the
> current code assumes they're descibing memory, which isn't true for HP's
> ia64 systems.
> 
There already a patch for that in -mm kernel

Matthieu

