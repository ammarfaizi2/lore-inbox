Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVCWFKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVCWFKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 00:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVCWFKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 00:10:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57731 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262785AbVCWFKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 00:10:21 -0500
Message-ID: <4240FA2F.4050901@pobox.com>
Date: Wed, 23 Mar 2005 00:10:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH libata-dev-2.6 03/05] libata: update ATA PT sense desc
 code
References: <20050317221753.53957EDF@lns1032.lss.emc.com> <20050317221753.15A7ADF6@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.15A7ADF6@lns1032.lss.emc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> 03_libata_update_desc_code.patch
> 
> 	Change the ATA pass through sense block descriptor code to
> 	0x09 per SAT
> 
> Signed-off-by: Brett Russ <russb@emc.com>

applied


