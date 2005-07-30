Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVG3CoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVG3CoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVG3CoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:44:16 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:37845 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262724AbVG3CoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 22:44:15 -0400
Subject: Re: [PATCH 35/82] remove linux/version.h from
	drivers/scsi/cpqfcTSinit.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050710193543.35.MfBvHx3206.2247.olh@nectarine.suse.de>
References: <20050710193543.35.MfBvHx3206.2247.olh@nectarine.suse.de>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 21:43:54 -0500
Message-Id: <1122691434.5108.30.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-10 at 19:35 +0000, Olaf Hering wrote:
> changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.
> remove code for obsolete kernels

I can't seem to get any of these patches to apply:

Applying 'remove linux/version.h from drivers/scsi/cpqfcTSinit.c'

patching file drivers/scsi/cpqfcTSinit.c
patch: **** malformed patch at line 4: #include <linux/config.h>

I've no idea what patch's problem is ... as far as I can tell there are
no line breaks or illegal characters in the email.

James


