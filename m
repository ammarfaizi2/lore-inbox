Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVCJQmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVCJQmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVCJQmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:42:44 -0500
Received: from vawad.err.no ([129.241.93.49]:3727 "EHLO vawad.err.no")
	by vger.kernel.org with ESMTP id S262711AbVCJQma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:42:30 -0500
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
From: Hans-Christian Egtvedt <hc@mivu.no>
To: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050310161825.GA28643@ucw.cz>
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no>
	 <200503041403.37137.adobriyan@mail.ru>
	 <d120d50005030406525896b6cb@mail.gmail.com>
	 <1109953224.3069.39.camel@charlie.itk.ntnu.no>
	 <d120d50005030408544462c9ea@mail.gmail.com>
	 <1110297660.3198.15.camel@server.customer.mivu.no>
	 <20050310161825.GA28643@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: MIVU Solutions DA
Date: Thu, 10 Mar 2005 17:41:42 +0100
Message-Id: <1110472902.3284.17.camel@server.customer.mivu.no>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 17:18 +0100, Vojtech Pavlik wrote:
> On Tue, Mar 08, 2005 at 05:01:00PM +0100, Hans-Christian Egtvedt wrote:
>  
> > I really don't think the controller can now anything about the size of
> > the screen.
> > 
> > I've attached version 1.2.1 of the driver, fixed some typo, code cleanup
> > and discovered I used depricated functions so I moved to the new correct
> > way of doing killing of the urb.
> 
> Pacth applied, with minor cleanups.

Could you send me your changes?

<snip patch file>

-- 
Hans-Christian Egtvedt <hc@mivu.no>
MIVU Solutions DA
