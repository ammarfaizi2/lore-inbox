Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTIKPXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTIKPXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:23:55 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:899 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S261359AbTIKPXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:23:54 -0400
Date: Thu, 11 Sep 2003 17:23:52 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>,
       =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
Subject: Re: horrible usb keyboard bug with latest tests
In-Reply-To: <20030911134608.GN15818@vega.digitel2002.hu>
Message-ID: <Pine.LNX.4.44.0309111722310.2161-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003, [iso-8859-2] Gábor Lénárt wrote:

> On Thu, Sep 11, 2003 at 05:57:44AM -0700, Mr. Mailing List wrote:
> > Ok, for the last few test kernels, there is a horribly
> > annoying usb keyboard bug.  after a while in X, or
> > just when you start putting some input, all the
> > keyboard lights on on my msnatpro keyboard.  after
> > that, the keycodes  are screwed up(like the left alt
> > button)
> > 
> > sometimes one key would stick, like
> > kkkkkkkkkkkkkkkkkkkkkkkkkk
> 
> For me too, even with a normal keyboard attached to the PS/2 keyboard port.

It happens to me since I instaled RH9. I've tried all the kernels to no 
success. In RH8 it definately did not happen, so it must be some user 
space thing.

Pau

