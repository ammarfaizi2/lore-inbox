Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTJ2TIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTJ2TIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:08:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:3761 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261294AbTJ2TIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:08:43 -0500
Date: Wed, 29 Oct 2003 11:07:16 -0800
From: Greg KH <greg@kroah.com>
To: Eric.Chacron@alcatel.fr
Cc: "Guo, Min" <min.guo@intel.com>, Steven Dake <sdake@mvista.com>,
       linux-raid@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Lars Marowsky-Bree <lmb@suse.de>,
       "Ling, Xiaofeng" <xiaofeng.ling@intel.com>,
       Mark Bellon <mbellon@mvista.com>, linux-kernel@vger.kernel.org,
       cgl_discussion@osdl.org
Subject: Re: [cgl_discussion] RE: ANNOUNCE: User-space System Device Enumation	(uSDE)
Message-ID: <20031029190715.GA4241@kroah.com>
References: <OF3ACB2DB7.10C92CBA-ONC1256DCE.00538D5B@netfr.alcatel.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF3ACB2DB7.10C92CBA-ONC1256DCE.00538D5B@netfr.alcatel.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 05:20:01PM +0100, Eric.Chacron@alcatel.fr wrote:
> 
> 
> >From a pure technical point of view  and from presentations made by the
> authors of u*** perspective
> i think uSDE could add some interresting features like a customizable
> naming policy.

udev doesn't provide such a feature right now?

> For instance: geographical addressing to identify devices using rack,
> subrack, slot numbers seems possible.

Sure, udev can do that today, if you have a way of identifying devices
in such a manner.

thanks,

greg k-h
