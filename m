Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268136AbUJGUii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268136AbUJGUii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268059AbUJGUh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 16:37:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11190 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268127AbUJGUf4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 16:35:56 -0400
Message-ID: <4165A89F.20900@pobox.com>
Date: Thu, 07 Oct 2004 16:35:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lsml@rtr.ca>
CC: Mark Lord <lkml@rtr.ca>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca> <20041007150709.B12688@infradead.org> <4165624C.5060405@rtr.ca> <416565DB.4050006@pobox.com> <4165A45D.2090200@rtr.ca>
In-Reply-To: <4165A45D.2090200@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I can put it another way.

Without seeing the code that uses the hooks, we cannot evaluate whether 
the hooks are needed, useful, or even properly implemented.  They are 
unreviewable.

Does this same argument hold true for ioctls?  Yes.  But (as noted in 
the previous email) ioctls and kernel API hooks are quite different.

	Jeff



