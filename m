Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWIKPRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWIKPRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIKPRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:17:35 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:42481 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S964856AbWIKPRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:17:34 -0400
Date: Mon, 11 Sep 2006 17:17:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Prevent legacy io access on pmac
Message-ID: <20060911151730.GA25244@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060911115354.GA23884@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, Olaf Hering wrote:

> * add check for parport_pc, exit on pmac.

How do I allow parport on PCI cards?
