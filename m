Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUFYNN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUFYNN0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 09:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUFYNN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 09:13:26 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:37637 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S266202AbUFYNNZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 09:13:25 -0400
Subject: Re: [linux-cifs-client] Re: Process hangs copying large file to
	cifs
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org,
       linux-cifs-client-bounces+sfrench=us.ibm.com@lists.samba.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <OF99D5C016.1C0D51B3-ON87256EBD.005E4E3F-86256EBD.005EBCEF@us.ibm.com>
References: <OF99D5C016.1C0D51B3-ON87256EBD.005E4E3F-86256EBD.005EBCEF@us.ibm.com>
Content-Type: text/plain
Organization: Graycell
Date: Fri, 25 Jun 2004 14:13:23 +0100
Message-Id: <1088169203.2411.3.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 13:13:24.0042 (UTC) FILETIME=[31DE5AA0:01C45AB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Qui, 2004-06-24 at 12:17 -0500, Steven French wrote:
> 
> > By the way, it appears like there is some problem with the /proc/fs/
> > cifs/Stats output. 
> 
> I had fixed this /proc/fs/cifs/Stats output to handle returning more
> than a few hundred 
> bytes of data correctly - but it looks like that change went in just
> after 2.6.7. The 
> patch is at: 
>    http://linux.bkbits.net:8080/linux-2.5/
> gnupatch@40d119caW030H7lkzfxGtxV6kcVnSQ 

Do you want me to retest to get the full output or was the previous one
enough?
-- 
Nuno Ferreira

