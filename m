Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTJaQc4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 11:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263399AbTJaQc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 11:32:56 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:34220 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263396AbTJaQcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 11:32:55 -0500
Message-ID: <3FA28C9A.5010608@pacbell.net>
Date: Fri, 31 Oct 2003 08:23:54 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>	<20031028013013.GA3991@kroah.com>	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>	<3FA12A2E.4090308@pacbell.net>	<16289.29015.81760.774530@napali.hpl.hp.com> <16289.55171.278494.17172@napali.hpl.hp.com>
In-Reply-To: <16289.55171.278494.17172@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> After spending a bit more time on this, it looks to me like the
> keyboard is crashing the system very early on.  

I think there are some devices that choke the HID
code; I recall someone reporting a mouse that did the
same kind of thing.  Do other kinds of keyboards do
the same thing, or is it just that one?

Vojtech may have other suggestions.

- Dave

