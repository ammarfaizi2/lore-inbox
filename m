Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbULPXJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbULPXJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbULPXJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:09:04 -0500
Received: from fire.osdl.org ([65.172.181.4]:53385 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbULPXIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:08:48 -0500
Message-ID: <41C2147D.1090603@osdl.org>
Date: Thu, 16 Dec 2004 15:04:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI aic7xxx: kill kernel 2.2 #ifdef's (fwd)
References: <20041216221802.GT12937@stusta.de>
In-Reply-To: <20041216221802.GT12937@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The patch forwarded below still applies and compiles against 
> 2.6.10-rc3-mm1.
> 
> Please apply.
> 
> ----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----
> 
> The patch below kills kernel 2.2 #ifdef's from the SCSI aic7xxx driver.

Hi Adrian,

I would really appreciate it if you could limit patches for major
subsystems to only the mailing list for those subsystems.

Is that feasible?

-- 
~Randy
