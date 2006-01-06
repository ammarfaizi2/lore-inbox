Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWAFVMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWAFVMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWAFVMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:12:45 -0500
Received: from pat.qlogic.com ([198.70.193.2]:29947 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S932510AbWAFVMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:12:44 -0500
Date: Fri, 6 Jan 2006 13:12:41 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/qla2xxx/Kconfig: two fixes
Message-ID: <20060106211241.GG13844@andrew-vasquezs-powerbook-g4-15.local>
References: <20060106163401.GP12131@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106163401.GP12131@stusta.de>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 06 Jan 2006 21:12:43.0433 (UTC) FILETIME=[EF212990:01C61305]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2006, Adrian Bunk wrote:

> This patch contains the following fixes for 
> drivers/scsi/qla2xxx/Kconfig:
> - add a help text for SCSI_QLA2XXX_EMBEDDED_FIRMWARE
> - the firmware modules must depend on SCSI_QLA2XXX to prevent
>   illegal configurations like SCSI_QLA2XXX=m, SCSI_QLA21XX=y
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Ack.

--
Andrew Vasquez
