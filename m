Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276989AbRJKWHj>; Thu, 11 Oct 2001 18:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276977AbRJKWHc>; Thu, 11 Oct 2001 18:07:32 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:21243 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276989AbRJKWHS>; Thu, 11 Oct 2001 18:07:18 -0400
Date: Thu, 11 Oct 2001 18:07:46 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: sergio@bruder.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: usb-uhci broken in 2.4.10-ac11?
Message-ID: <20011011180746.A30928@devserv.devel.redhat.com>
In-Reply-To: <200110112156.f9BLuhG29509@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110112156.f9BLuhG29509@devserv.devel.redhat.com>; from zaitcev@redhat.com on Thu, Oct 11, 2001 at 05:56:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: sergio@bruder.net
> Date: Thu, 11 Oct 2001 16:36:47 -0300
> To: linux-kernel <linux-kernel@vger.kernel.org>

> I have a USB printer that was working fine with 2.4.10-ac7.

> Just switched to 2.4.10-ac11 and now I get the following at usb-uhci's
> modprobe:

Can you do narrowing for us, please?
Also, make sure you are on -ac11 and not -ac12, because I see no
USB changes between -ac7 and -ac11, but -ac12 introduces a bunch.

-- Pete
