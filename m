Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWGXFcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWGXFcN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 01:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWGXFcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 01:32:13 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:20754 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1750940AbWGXFcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 01:32:12 -0400
Date: Mon, 24 Jul 2006 01:31:20 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: "David Rientjes" <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc2] Fix typos in /Documentation : 'F'-'G'
Message-Id: <20060724013120.dc71ab61.kernel1@cyberdogtech.com>
In-Reply-To: <9ec263480607232144g5e283156p86e5f84e8a92380c@mail.google.com>
References: <20060723124920.76a5d725.kernel1@cyberdogtech.com>
	<9ec263480607232144g5e283156p86e5f84e8a92380c@mail.google.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Mon, 24 Jul 2006 01:31:32 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Mon, 24 Jul 2006 01:31:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006 21:44:49 -0700
"David Rientjes" <rientjes@google.com> wrote:

> On 7/23/06, Matt LaPlante <kernel1@cyberdogtech.com> wrote:
> > --- a/Documentation/input/ff.txt        2006-07-22 15:09:50.000000000 -0400
> > +++ b/Documentation/input/ff.txt        2006-07-22 17:07:10.000000000 -0400
> > @@ -13,7 +13,7 @@
> >  At the moment, only I-Force devices are supported, and not officially. That
> >  means I had to find out how the protocol works on my own. Of course, the
> >  information I managed to grasp is far from being complete, and I can not
> > -guarranty that this driver will work for you.
> > +guaranty that this driver will work for you.
> >  This document only describes the force feedback part of the driver for I-Force
> >  devices. Please read joystick.txt before reading further this document.
> >
> 
> guaranty?

It does look weird, although apparently it is not incorrect:
http://www.m-w.com/dictionary/guaranty

Generally speaking I've been trying to change as little as possible to achieve correctness...if we want to declare "guarantee" the official spelling for the kernel, theres no reason not to change this one too. :)

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

