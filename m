Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUCGQyM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbUCGQxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:53:53 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:34262 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262264AbUCGQxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:53:46 -0500
Date: Sun, 7 Mar 2004 11:53:44 -0500
From: Willem Riede <wrlk@riede.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: wrlk@riede.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] remove dead ATAPI multi-lun support (used for ide-scsi)
Message-ID: <20040307165344.GM29509@serve.riede.org>
Reply-To: wrlk@riede.org
References: <200402202247.02345.bzolnier@elka.pw.edu.pl> <20040307134905.GK29509@serve.riede.org> <404B4A1D.80107@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <404B4A1D.80107@pobox.com> (from jgarzik@pobox.com on Sun, Mar 07, 2004 at 11:13:17 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.03.07 11:13, Jeff Garzik wrote:
> Willem Riede wrote:
> >
> > I have verified that this works with my PD/CD drive, the patch to ide-scsi.c
> > that I suggest (against linux-2.6.4-rc1-mm2) is below.
> 
> 
> I have a multi-LUN ATAPI CD changer here...

If you can test my patch with it, that would be great. 
My CD changer doesn't report multiple LUNs :-(

Thanks, Willem Riede.
