Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVHYTVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVHYTVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVHYTVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:21:20 -0400
Received: from mail25.sea5.speakeasy.net ([69.17.117.27]:60079 "EHLO
	mail25.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751199AbVHYTVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:21:19 -0400
Date: Thu, 25 Aug 2005 15:21:16 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][-mm] Generic VFS fallback for security xattrs
In-Reply-To: <1124991803.3873.125.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.63.0508251520510.16199@excalibur.intercode>
References: <1124991803.3873.125.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Stephen Smalley wrote:

> Please include in -mm for wider testing prior to merging in 2.6.14.

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>
