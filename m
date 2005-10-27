Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVJ0WM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVJ0WM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 18:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVJ0WM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 18:12:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31962 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932671AbVJ0WM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 18:12:57 -0400
Date: Thu, 27 Oct 2005 18:12:53 -0400
From: Dave Jones <davej@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051027221253.GA25932@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Alejandro Bonilla <abonilla@linuxwireless.org>,
	linux-kernel@vger.kernel.org
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org> <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130451071.5416.32.camel@blade>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:11:11AM +0200, Marcel Holtmann wrote:
 > Hi Dave,
 > 
 > > Some boards at least have a BIOS option to support 'memory hoisting'
 > > to map the 'lost' memory above the 4G address space.
 > > 
 > > I suspect a lot of the lower-end (and older) boards however don't have
 > > this option, as they were not tested with 4GB.
 > 
 > do you have any information about remapping support of the D945GNT
 > motherboard from Intel.

I've not come across an EM64T with that much RAM, so I've not had
reason to go looking.. Sorry.

		Dave

