Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbTLHAx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 19:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbTLHAx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 19:53:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:28831 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265160AbTLHAx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 19:53:26 -0500
Date: Sun, 7 Dec 2003 16:47:42 -0800
From: Greg KH <greg@kroah.com>
To: "Jonathan A. Zdziarski" <jonathan@nuclearelephant.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 Test 11 Freeze on USB Disconnect
Message-ID: <20031208004742.GB23644@kroah.com>
References: <1070825737.2978.7.camel@tantor.nuclearelephant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070825737.2978.7.camel@tantor.nuclearelephant.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 02:35:38PM -0500, Jonathan A. Zdziarski wrote:
> Greetings,
> 
> I recently upgraded from 2.4.20-24 to 2.6 Test 11 using a Redhat
> distribution.  Got everything up and running great, except the entire
> system appears to freeze (requiring a hardware reset) when I disconnect
> my bluetooth device.

Is there any way you can see if an oops happened?  Without that it will
be pretty hard to debug this.

thanks,

greg k-h
