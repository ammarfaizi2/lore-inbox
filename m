Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUAGQMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUAGQMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:12:09 -0500
Received: from mail0.lsil.com ([147.145.40.20]:26346 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S266230AbUAGQMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:12:00 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703A756AC@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <Emoore@lsil.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com
Subject: RE: [PATCH] 2.6.1-rc2 - MPT Fusion driver 3.00.00 update
Date: Wed, 7 Jan 2004 11:11:53 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs support is on my todo list.  
Probally Feburary timeframe.

Eric

On Tuesday, January 06, 2004 9:40 PM, Matt Domsch wrote:
> On Tue, Jan 06, 2004 at 05:08:47PM -0700, Eric Moore wrote:
> > Here's an driver update for mpt fusion driver version 3.00.00.
> 
> Eric, since this is for 2.6.x, need the driver export anything in
> /proc anymore, preferring to export via sysfs instead?
> 
> Thanks,
> Matt
> 
> -- 
> Matt Domsch
> Sr. Software Engineer, Lead Engineer
> Dell Linux Solutions www.dell.com/linux
> Linux on Dell mailing lists @ http://lists.us.dell.com
> 
