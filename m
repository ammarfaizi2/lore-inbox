Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWCFWCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWCFWCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWCFWCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:02:48 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:61625
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932366AbWCFWCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:02:48 -0500
Date: Mon, 6 Mar 2006 14:02:25 -0800
From: Greg KH <greg@kroah.com>
To: Michael Bender <Michael.Bender@Sun.COM>
Cc: s.schmidt@avm.de, kkeil@suse.de, libusb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       opensuse-factory@opensuse.org, torvalds@osdl.org
Subject: Re: [Libusb-devel] Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060306220225.GA20265@kroah.com>
References: <20060217230004.GA15492@kroah.com> <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de> <20060306170542.GB8142@kroah.com> <440CA520.8070507@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440CA520.8070507@sun.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 01:09:52PM -0800, Michael Bender wrote:
> (Since this came to me via the libusb list, and we've kind of
> gone past libusb-specific-related discussion, I thought I'd
> add another question to the thread).
> 
> What's the rationale behind the dichotomy between userspace
> and kernel licensing models?

Hm, how about starting a new thread for this?  As it's way outside the
scope of this one, _and_ it's pretty much off-topic for all of these
lists :)

As for the rationale, see the lkml archives for details.

thanks,

greg k-h
