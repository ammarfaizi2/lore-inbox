Return-Path: <linux-kernel-owner+w=401wt.eu-S964870AbXADPdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbXADPdq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbXADPdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:33:46 -0500
Received: from rtr.ca ([64.26.128.89]:1432 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964870AbXADPdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:33:45 -0500
Message-ID: <459D1E55.60206@rtr.ca>
Date: Thu, 04 Jan 2007 10:33:41 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Ed Sweetman <safemode2@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S.M.A.R.T no longer available in 2.6.20-rc2-mm2 with libata
References: <459C5D6C.5010509@comcast.net>
In-Reply-To: <459C5D6C.5010509@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> Not sure what went on between 2.6.19-rc5-mm2 and 2.6.20-rc2-mm2 in 
> libata land but SMART is no longer available on my hdds. 

It's working for me with 2.6.20-rc3, ata_piix libata driver.

-ml
