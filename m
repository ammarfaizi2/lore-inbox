Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVCWEZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVCWEZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVCWEZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:25:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22401 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262773AbVCWEZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:25:10 -0500
Message-ID: <4240EF9A.7050701@pobox.com>
Date: Tue, 22 Mar 2005 23:24:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata-dev-2.6 04/05] libata: support descriptor sense
 in ctrl page
References: <20050317221753.53957EDF@lns1032.lss.emc.com> <20050317221753.D65B81E4@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.D65B81E4@lns1032.lss.emc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> 04_libata_control_pg_desc_bit.patch
> 
> 	libata must support the descriptor format sense blocks as they
> 	are required to properly report results of ATA pass through
> 	commands as well as other SCSI commands reporting 48b LBAs.
> 	This patch adjusts the control mode page to properly report
> 	this.
> 
> Signed-off-by: Brett Russ <russb@emc.com>

applied


