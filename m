Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWD2VAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWD2VAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWD2VAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 17:00:44 -0400
Received: from main.gmane.org ([80.91.229.2]:26761 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750742AbWD2VAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 17:00:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [RFC] make PC Speaker driver work on x86-64
Date: Sat, 29 Apr 2006 23:00:15 +0200
Message-ID: <pan.2006.04.29.21.00.09.180837@free.fr>
References: <200604291830.k3TIUA23009336@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: discuss@x86-64.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le Sat, 29 Apr 2006 20:30:10 +0200, Mikael Pettersson a écrit :


> 
> Is there a better way to do this? ACPI?
> 
Yes, I believe using PNP layer (that use ACPI with pnpacpi) with PNP0800
will be cleaner.

Matthieu

