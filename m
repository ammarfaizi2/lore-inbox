Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVCaLE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVCaLE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCaLE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:04:57 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:37249 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261307AbVCaLEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:04:53 -0500
Subject: Re: [RFC/PATCH] network configs: disconnect network options from
	drivers
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev <netdev@oss.sgi.com>
In-Reply-To: <20050330234709.1868eee5.randy.dunlap@verizon.net>
References: <20050330234709.1868eee5.randy.dunlap@verizon.net>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1112267088.1089.53.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 31 Mar 2005 06:04:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 02:47, Randy.Dunlap wrote:
> RFC:  This is a work-in-progress (WIP), not yet completed.
> 
> A few people dislike that the Networking Options menu is inside
> the Device Drivers/Networking menu.  This patch moves the
> Networking Options menu to immediately before the Device Drivers menu,
> renames it to "Networking options and protocols", & moves most
> protocols to more logical places (IMHOOC).
> 

About time someone brave did this.

cheers,
jamal


