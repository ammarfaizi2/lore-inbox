Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVBNKHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVBNKHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 05:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVBNKHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 05:07:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261381AbVBNKHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 05:07:15 -0500
Message-ID: <42107840.1000504@redhat.com>
Date: Mon, 14 Feb 2005 11:06:56 +0100
From: Harald Hoyer <harald@redhat.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
References: <20050211201013.GA6937@ucw.cz>
In-Reply-To: <20050211201013.GA6937@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Hi!
> 
> I've reimplemented the Lifebook touchscreen driver using libps2 and
> input, to make it short and fitting into the kernel drivers.
> 
> Please comment on code and test for functionality!
> 
> PS.: The driver should register two input devices. It doesn't yet,
> since that isn't very straightforward in the psmouse framework.

Sorry, I have no more Lifebook available to test :-/

Have fun!
