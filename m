Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVB1LTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVB1LTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 06:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVB1LTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 06:19:35 -0500
Received: from gate.corvil.net ([213.94.219.177]:60679 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261174AbVB1LTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 06:19:33 -0500
Message-ID: <4222FE2A.9070803@draigBrady.com>
Date: Mon, 28 Feb 2005 11:19:06 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: pasik@iki.fi, LM Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] Preliminary w83627ehf hardware monitoring driver
References: <BIe4VCVx.1109588428.5008080.khali@localhost>
In-Reply-To: <BIe4VCVx.1109588428.5008080.khali@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> I am not familiar with watchdogs. I'd invite you to get in touch with
> the author and/or maintainer of the w83627hf_wdt driver, or possibly try
> to debug it yourself. Datasheets are freely available from Winbond for
> both the W83627HF and W83627THF:
>   http://www.winbond.com/e-winbondhtm/partner/b_2_d_2.htm

He already contacted me (indirectly).
A test program I sent showed the timer in the winbond
counting down, but the reboot never happened.
I would need to get access to the hardware to debug further.

-- 
Pádraig Brady - http://www.pixelbeat.org
--
