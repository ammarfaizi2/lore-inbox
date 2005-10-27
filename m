Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbVJ0WRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVJ0WRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVJ0WRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:17:15 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:16519 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932675AbVJ0WRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:17:14 -0400
Subject: Re: 4GB memory and Intel Dual-Core system
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Jones <davej@redhat.com>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051027221253.GA25932@redhat.com>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade>
	 <20051027211203.M33358@linuxwireless.org>
	 <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade>
	 <20051027221253.GA25932@redhat.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 00:17:01 +0200
Message-Id: <1130451421.5416.35.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

>  > > Some boards at least have a BIOS option to support 'memory hoisting'
>  > > to map the 'lost' memory above the 4G address space.
>  > > 
>  > > I suspect a lot of the lower-end (and older) boards however don't have
>  > > this option, as they were not tested with 4GB.
>  > 
>  > do you have any information about remapping support of the D945GNT
>  > motherboard from Intel.
> 
> I've not come across an EM64T with that much RAM, so I've not had
> reason to go looking.. Sorry.

am I really the first person trying to use that board with 4 GB of RAM
and an Intel Dual-Core with EM64T :(

Regards

Marcel


