Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265104AbRFZTrw>; Tue, 26 Jun 2001 15:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbRFZTrn>; Tue, 26 Jun 2001 15:47:43 -0400
Received: from alog0081.analogic.com ([208.224.220.96]:16900 "EHLO
	quark.analogic.com") by vger.kernel.org with ESMTP
	id <S265102AbRFZTrf>; Tue, 26 Jun 2001 15:47:35 -0400
Date: Tue, 26 Jun 2001 15:51:33 -0400 (EDT)
From: "Richard B. Johnson" <johnson@quark.analogic.com>
Reply-To: rjohnson@analogic.com
To: linux-kernel@vger.kernel.org
Subject: Duplicate IP ??
Message-ID: <Pine.LNX.3.95.1010626154101.14565A-100000@quark.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just got a bunch of messages from vger.kernel.org, sent to
root@chaos.analogic.com, claiming a "local configuration error"
and some kind of a loop.

There is no configuration that has changed on that machine for
at least two years although our firewall got updated last week
to fix the ECN bug.

I checked with ns.uu.net to see if the machine address was still
resolvable, it is.

I can `telnet vger.kernel.org 25`. That connectivity works.
So I don't get any mail from vger.kernel.org.  What goes?

Dick Johnson


