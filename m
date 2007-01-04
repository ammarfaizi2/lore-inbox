Return-Path: <linux-kernel-owner+w=401wt.eu-S932246AbXADDst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbXADDst (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbXADDst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:48:49 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:4329 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932246AbXADDss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:48:48 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ed Sweetman <safemode2@comcast.net>
Subject: Re: S.M.A.R.T no longer available in 2.6.20-rc2-mm2 with libata
Date: Thu, 4 Jan 2007 03:49:16 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <459C5D6C.5010509@comcast.net>
In-Reply-To: <459C5D6C.5010509@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701040349.16650.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 January 2007 01:50, Ed Sweetman wrote:
> Not sure what went on between 2.6.19-rc5-mm2 and 2.6.20-rc2-mm2 in
> libata land but SMART is no longer available on my hdds.   I'm assuming
> this is not the intended behavior.
>
> In case this is chipset specific, IDE interface: nVidia Corporation
> CK804 Serial ATA Controller (rev f3)
>
> I'm using Libata nvidia driver, the drives happen to be sata drives, but
> even the pata ones no longer report having SMART.

What program are you trying to use here? As I reported around -rc1 time, 
hddtemp is broken by 2.6.20-rc but Jens posted a patch to fix it.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
