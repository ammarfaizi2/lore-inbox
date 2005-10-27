Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbVJ0VTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVJ0VTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbVJ0VTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:19:18 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:13447 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932637AbVJ0VTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:19:18 -0400
Subject: Re: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051027211203.M33358@linuxwireless.org>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade>
	 <20051027211203.M33358@linuxwireless.org>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 23:19:15 +0200
Message-Id: <1130447955.5416.25.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alejandro,

> > so there is no way to give me back the "lost" memory. Is it possible
> > that another motherboard might help?
> 
> AFAIK, No. AMD and Intel will always do the same thing until we all move to
> real IA64.
> 
> Unless there is some sort of kernel hack that will do some crazy thing to give
> you the power there.

do you think that activating NUMA emulation might help?

> But hey, look at it this way, if you remove 1GB, you will lose the Dual
> Channel capability.

I could have bought two 512 MB modules ;)

Regards

Marcel


