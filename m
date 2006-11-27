Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758414AbWK0RWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758414AbWK0RWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758443AbWK0RWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:22:40 -0500
Received: from avexch1.qlogic.com ([198.70.193.115]:33466 "EHLO
	avexch1.qlogic.com") by vger.kernel.org with ESMTP id S1758411AbWK0RWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:22:39 -0500
Date: Mon, 27 Nov 2006 09:22:38 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-driver@qlogic.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
Subject: Re: [-mm patch] make qla2x00_reg_remote_port() static
Message-ID: <20061127172238.GA21083@andrew-vasquezs-computer.local>
References: <20061123021703.8550e37e.akpm@osdl.org> <20061124014601.GQ3557@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061124014601.GQ3557@stusta.de>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 27 Nov 2006 17:22:39.0224 (UTC) FILETIME=[A36EC780:01C71248]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Adrian Bunk wrote:

> On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-rc5-mm2:
> >...
> >  git-scsi-misc.patch
> >...
> >  git trees
> >...
> 
> qla2x00_reg_remote_port() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
