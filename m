Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTFUH2g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbTFUH2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:28:36 -0400
Received: from home.wiggy.net ([213.84.101.140]:27586 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S265083AbTFUH2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:28:35 -0400
Date: Sat, 21 Jun 2003 09:42:37 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030621074237.GC28238@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3EF3F08B.5060305@aros.net> <E19Tbyp-0004mi-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19Tbyp-0004mi-00@calista.inka.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Bernd Eckenfels wrote:
> Is anybody aware of a journalling nbd, which keeps track of unsynced
> changes, so a fast reintegration is possible?

Didn't drdb do something like that?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

