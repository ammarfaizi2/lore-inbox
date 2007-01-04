Return-Path: <linux-kernel-owner+w=401wt.eu-S965087AbXADWN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbXADWN1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965089AbXADWN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:13:27 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:41712 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965087AbXADWN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:13:27 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 17:13:27 EST
Message-ID: <459D7AC8.1000907@comcast.net>
Date: Thu, 04 Jan 2007 17:08:08 -0500
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: S.M.A.R.T no longer available in 2.6.20-rc2-mm2 with libata
References: <459C5D6C.5010509@comcast.net> <459D1E55.60206@rtr.ca>
In-Reply-To: <459D1E55.60206@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Ed Sweetman wrote:
>> Not sure what went on between 2.6.19-rc5-mm2 and 2.6.20-rc2-mm2 in 
>> libata land but SMART is no longer available on my hdds. 
>
> It's working for me with 2.6.20-rc3, ata_piix libata driver.
>
> -ml
>

Well, not in the sata_nv libata driver.  The only change I make is the 
kernel (config is basically the same and nothing in the bios or hardware 
is altered).  
