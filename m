Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWCGDIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWCGDIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbWCGDIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:08:17 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:31662 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1752472AbWCGDIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:08:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Lanslott Gish" <lanslott.gish@gmail.com>
Subject: Re: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Date: Mon, 6 Mar 2006 22:08:13 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       "Greg KH" <greg@kroah.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Alan Cox" <alan@redhat.com>
References: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com>
In-Reply-To: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603062208.13922.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 04:14, Lanslott Gish wrote:
> hi,
> 
> this is the first version of the patch from a newbie :)
> add support for PANJIT TouchSet USB touchscreen device.
>

Hi,

I am reading this and it looks like twin brother of touchkitusb.c
Is there any chance we can combine these together?

-- 
Dmitry
