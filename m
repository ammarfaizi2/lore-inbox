Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVCQR2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVCQR2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 12:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVCQR2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 12:28:18 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:53888 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261979AbVCQR2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 12:28:11 -0500
Subject: RE: [ANNOUNCE][PATCH] drivers/scsi/megaraid/megaraid_{mm,mbox}
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <sju@lsil.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E5703662770@exa-atlanta>
References: <0E3FA95632D6D047BA649F95DAB60E5703662770@exa-atlanta>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 12:27:56 -0500
Message-Id: <1111080476.5994.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 11:48 -0500, Ju, Seokmann wrote:
> On Thursday, March 17, 2005 1:26 AM, Andrew wrote:
> > Some of these things have already been done in Linus's 
> > post-2.6.11 tree and
> > you patch throws lots of rejects.  Please always work against the most
> > recent kernel - 2.6.11 is very out of date.
> Thank you for correction. I've created NEW patch against 2.6.11.4 which is
> latest from kernel.org.

This is still rejecting:

patching file drivers/scsi/megaraid/megaraid_mm.c
Hunk #2 FAILED at 43.
Hunk #4 FAILED at 68.
Hunk #5 FAILED at 1217.
Hunk #6 FAILED at 1225.
Hunk #7 FAILED at 1245.
5 out of 7 hunks FAILED -- saving rejects to file
drivers/scsi/megaraid/megaraid_mm.c.rej

Could you rebase this patch to the bk snapshots so we can look at
applying it?

Thanks,

James


