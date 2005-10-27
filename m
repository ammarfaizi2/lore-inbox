Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVJ0VHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVJ0VHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVJ0VHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:07:45 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:12423 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932259AbVJ0VHo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:07:44 -0400
Subject: Re: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051027205921.M81949@linuxwireless.org>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 23:07:41 +0200
Message-Id: <1130447261.5416.20.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alejandro,

> > the board in this system is a Intel D945GNT and the box tells me the
> > maximum supported amount of RAM is 4 GB. So there should be a way to
> > address this amount memory.
> 
> The board did take the 4GB of RAM and it is finding them, therefore supports
> them. It is just not designed to give a full 4GB of RAM to the system, it only
> gives 3.4XGB RAM and the rest is really not used, then basically the system
> just tries to give the 0.6xGB RAM remaining a task by it being used by "System
> Resources"
> 
> This isn't really Linux dependant.

so there is no way to give me back the "lost" memory. Is it possible
that another motherboard might help?

Regards

Marcel


