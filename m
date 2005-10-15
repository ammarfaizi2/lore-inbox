Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVJORXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVJORXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 13:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVJORXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 13:23:53 -0400
Received: from mail.isurf.ca ([66.154.97.68]:53729 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S1750788AbVJORXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 13:23:53 -0400
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [OOPS] nfsv4 in linux 2.6.13 (-ck7)
Date: Sat, 15 Oct 2005 13:23:43 -0400
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200510121903.04485.ace@staticwave.ca> <1129304995.8571.43.camel@lade.trondhjem.org>
In-Reply-To: <1129304995.8571.43.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510151323.43224.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 14, 2005 11:49, Trond Myklebust wrote:
> Does the attached patch fix it for you?
> 
> Cheers,
>   Trond

This patch http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.13-1/linux-2.6.13-001-NFS_ALL_MODIFIED.dif
I found already fixed my problem, I applied your patch on top and everything seems to be working fine.

-- 
Gabriel A. Devenyi
ace@staticwave.ca
