Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269971AbUJSWXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269971AbUJSWXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbUJSWU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:20:29 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:46103 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269926AbUJSWOU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:14:20 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=py/Tu3e+ydfeaUljeK4jfrtF6FBWPMBwcdPWaUi2nvqqyu/H/p+FA3UO/fXFCga1L7vO0lhCAfO6ylAow+v6FZZ2137A8e6fobE4gji9be52TqQYe4JP86xr9D2t8rUhtCixrUVVmko38T2OtYvZ/cl/sNsi677601gTSTUpi1c
Message-ID: <9e4733910410191514db82abc@mail.gmail.com>
Date: Tue, 19 Oct 2004 18:14:19 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Russell Miller <rmiller@duskglow.com>
Subject: Re: 2.6.9 DRM compile problem
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410191613.35691.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410191613.35691.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

Gamma is marked BROKEN

-- 
Jon Smirl
jonsmirl@gmail.com
