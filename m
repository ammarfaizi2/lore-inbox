Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVAFARM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVAFARM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 19:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVAFARM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 19:17:12 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:43914 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262673AbVAFAPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 19:15:50 -0500
Subject: Re:  Re: [PATCH] get/set FAT filesystem attribute bits
From: Nicholas Miell <nmiell@comcast.net>
To: 7eggert@gmx.de
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E1CmLBc-0001ZU-00@be1.7eggert.dyndns.org>
References: <fa.i537e7s.1d6m90c@ifi.uio.no> <fa.ihdqkec.1i5umji@ifi.uio.no>
	 <E1CmLBc-0001ZU-00@be1.7eggert.dyndns.org>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 16:15:45 -0800
Message-Id: <1104970545.3810.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 01:07 +0100, Bodo Eggert wrote:
> H. Peter Anvin wrote:
> > By author:    Bodo Eggert <7eggert@gmx.de>
> 
> >> > a = archive
> >> 
> >> Should be the "dump" attribute
> 
> > What dump attribute?
> 
> The one described in man chattr.

You mean "no dump (d)", the attribute that says this file should never
be backed up and is in no way related to the Archive bit, which says
that this file has been modified since the last time the Archive bit was
cleared?

-- 
Nicholas Miell <nmiell@comcast.net>

