Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUAGL1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUAGL1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:27:31 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:53510 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266191AbUAGL1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:27:25 -0500
Date: Wed, 7 Jan 2004 12:03:19 +0100
From: DervishD <raul@pleyades.net>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Greg KH <greg@kroah.com>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird problems with printer using USB
Message-ID: <20040107110319.GI15884@DervishD>
References: <20040105192430.GA15884@DervishD> <20040105194537.GJ22177@kroah.com> <3FFABFB7.2050700@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FFABFB7.2050700@grupopie.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Paulo :)

 * Paulo Marques <pmarques@grupopie.com> dixit:
> >>   I'm using kernel 2.4.21, if this matters...
> >It does.  I'd recommend trying 2.4.23-pre3, as it had a usb printer
> >driver update in it.
> >Or 2.6.0, that also should be better.
> I submitted a patch against kernel 2.6.0 to correct a bug in the usblp 
> write function. It is probably not related to your problem, but if using a 
> 2.6.0 kernel doesn't solve your problem, you can try it anyway to see if it 
> helps.

    I don't plan using 2.6.0 by now, but if I can, I'll test and tell
here the results. First I want to check with a shorter USB cable.

    Thanks a lot for your help :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
