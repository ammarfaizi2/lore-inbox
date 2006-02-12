Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWBLVOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWBLVOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWBLVOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:14:15 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:44301 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750883AbWBLVOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:14:15 -0500
Date: Sun, 12 Feb 2006 22:14:06 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060212211406.GA48606@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <20060212120450.GA93069@dspnet.fr.eu.org> <20060212164633.GA2941@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212164633.GA2941@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 08:46:33AM -0800, Greg KH wrote:
> On Sun, Feb 12, 2006 at 01:04:51PM +0100, Olivier Galibert wrote:
> > You need to call udevinfo for that, or parse /dev/.udev/*.  Do you
> > think it would be possible to have hotplug/udev/whatever exists in the
> > future to give that information back in the kernel and have it appear
> > in sysfs?
> 
> No.  Why would it when it is very simple to query udevinfo for that?

In order not to depend on a userland package for the kernel service of
device enumeration?  It's udevinfo now, what will it be in two years?

  OG.



