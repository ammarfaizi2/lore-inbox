Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264973AbRFUOBk>; Thu, 21 Jun 2001 10:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbRFUOBa>; Thu, 21 Jun 2001 10:01:30 -0400
Received: from mail3.noris.net ([62.128.1.28]:50089 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id <S264973AbRFUOBR>;
	Thu, 21 Jun 2001 10:01:17 -0400
Mime-Version: 1.0
Message-Id: <p05100304b757adbbacd1@[10.2.6.42]>
In-Reply-To: <20010621235025.J30872@higherplane.net>
In-Reply-To: <20010621235025.J30872@higherplane.net>
Date: Thu, 21 Jun 2001 15:58:33 +0200
To: john slee <indigoid@higherplane.net>,
        "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
From: Matthias Urlichs <smurf@noris.de>
Subject: Re: Is it useful to support user level drivers
Cc: Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:50 +1000 2001-06-21, john slee wrote:
>i believe libgpio uses the existing usb/iee1394/serial/parallel
>interfaces to provide a limited userspace driver capability.

That only means, however, that the specific kernel drivers explicitly 
support mid-level usermode access.

They still handle the actual hardware state changes without usermode support.

-- 
Matthias Urlichs
