Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUJGPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUJGPhe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUJGPhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:37:34 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:38333 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267319AbUJGPh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:37:28 -0400
Message-ID: <4165624C.5060405@rtr.ca>
Date: Thu, 07 Oct 2004 11:35:40 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <416547B6.5080505@rtr.ca> <20041007150709.B12688@infradead.org>
In-Reply-To: <20041007150709.B12688@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which typedefs do you mean?  Most all of the original ones are gone.

And the EXPORT_SYMBOLS() have not been vetoed to my knowledge.
They're required for addtional driver extensions that are being
provided later one, as GPL'd source code.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
