Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUIUARF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUIUARF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 20:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUIUARE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 20:17:04 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61145 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267411AbUIUARC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 20:17:02 -0400
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)
	Denial of Service Attack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Paul Jakma <paul@clubi.ie>, Ville Hallivuori <vph@iki.fi>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87sm9cmwd5.fsf@deneb.enyo.de>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf>
	 <1095008692.11736.11.camel@localhost.localdomain>
	 <20040912192331.GB8436@hout.vanvergehaald.nl>
	 <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
	 <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org>
	 <20040913201113.GA5453@vph.iki.fi>
	 <Pine.LNX.4.61.0409141553260.23011@fogarty.jakma.org>
	 <1095174633.16990.19.camel@localhost.localdomain>
	 <87sm9cmwd5.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095721974.28810.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 00:12:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-20 at 23:03, Florian Weimer wrote:
> ndomization, quite a lot more. Of course
> > its much easier to just send "must fragment, size 68" icmp replies and
> > guess them that way.
> 
> Is this attack documented anywhere?

Bugtraq years ago and also in the discussions of the IP sec protocol
design flaws when it was being specified

