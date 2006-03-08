Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWCHFYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWCHFYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 00:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWCHFYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 00:24:30 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28842
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750743AbWCHFYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 00:24:30 -0500
Date: Tue, 7 Mar 2006 21:24:24 -0800
From: Greg KH <greg@kroah.com>
To: Lanslott Gish <lanslott.gish@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Fwd: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Message-ID: <20060308052424.GB29867@kroah.com>
References: <38c09b90603060114n79dcc45p499603b614bbbe20@mail.gmail.com> <200603062208.13922.dtor_core@ameritech.net> <38c09b90603071742i4e1463b8sa332fb79dd67f10d@mail.gmail.com> <38c09b90603071957q28e6d4c6xe226ab8a7f0d581a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38c09b90603071957q28e6d4c6xe226ab8a7f0d581a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 11:57:19AM +0800, Lanslott Gish wrote:
> ---------- Forwarded message ----------
> From: Lanslott Gish <lanslott.gish@gmail.com>
> Date: Mar 8, 2006 9:42 AM
> Subject: Re: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
> To: Dmitry Torokhov <dtor_core@ameritech.net>
> 
> 
> yes, i wrote this module from the same source model.
> 
> but as i know, there are two products designs from two corps.
> 
> or maybe modified a better name avoid mess?
> anybody any idea? ;)

How about just modifying the original to handle your device too?  If it
is simpler, that way we share code and keep the number of individual
drivers down (not that that is a problem...)

Do you think that is possible?

thanks,

gregk -h
