Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTKYSCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 13:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTKYSCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 13:02:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:9939 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262792AbTKYSCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 13:02:51 -0500
Date: Tue, 25 Nov 2003 10:27:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Cirrus Logic CS 4614/22/24 driver (IBM thinkpad T21)
Message-ID: <50920000.1069784874@flay>
In-Reply-To: <s5hk75o20ib.wl@alsa2.suse.de>
References: <941270000.1069458415@flay> <s5hk75o20ib.wl@alsa2.suse.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At Fri, 21 Nov 2003 15:46:55 -0800,
> Martin J. Bligh wrote:
>> 
>> Has anyone got the driver for this thing to work for more than about
>> 24 hours? Seems to descend slowly into crackly hell. Or are there any
>> ways to debug these damned things?
> 
> well, this chip has a relatively complex DSP setting...
> 
> i got reports that adjusting the mixer volumes may fix such an
> occasional noise.
> also, you can try the old DSP codes in kernel config.

Mmmm ... OK - but how? I can't see anything obvious.

Thanks,

M.

