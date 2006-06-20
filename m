Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWFTPo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWFTPo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWFTPo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:44:28 -0400
Received: from lixom.net ([66.141.50.11]:26792 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751325AbWFTPo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:44:28 -0400
Date: Tue, 20 Jun 2006 10:43:04 -0500
To: arnd@arndb.de
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Cbe-oss-dev] [patch 01/20] cell: add RAS support
Message-ID: <20060620154304.GD4845@pb15.lixom.net>
References: <20060619183315.653672000@klappe.arndb.de> <20060619183404.144740000@klappe.arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619183404.144740000@klappe.arndb.de>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:33:16PM +0200, arnd@arndb.de wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This is a first version of support for the Cell BE "Reliability,
> Availability and Serviceability" features.

Does it really make sense to do this under a config option? I don't see
why anyone would not want to know that their machine is about to melt.


-Olof

