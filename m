Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTDQQV4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 12:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTDQQV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 12:21:56 -0400
Received: from cdrobot.com ([65.70.252.73]:48089 "EHLO mainsrv.cdrobot.com")
	by vger.kernel.org with ESMTP id S261413AbTDQQVz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 12:21:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Help with virus/hackers
Date: Thu, 17 Apr 2003 11:34:03 -0500
Message-ID: <78939086E7E52D4A9CDBEAB7A609781201F68B@mainsrv.cdrobot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help with virus/hackers
Thread-Index: AcME+DJiJdWizhtjQj2zNdg+cazPXwABde3g
From: "Kenny Mann" <Kennymann@cdrobot.com>
To: "John Bradford" <john@grabjohn.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <root@chaos.analogic.com>, "joe briggs" <jbriggs@briggsmedia.com>,
       <linux-kernel@vger.kernel.org>, <samba@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've often wondered whether it would be worth connecting a
>very large serial EEPROM to a serial port interface, and
>have it effectively appear as a solid state printer, (to
>that you could cheaply log to an unmodifyable device).
>Has anybody ever tried this?

>John.

Dot Matrix or an old printer would come in handy here with
a (near-)infinite number of paper feed. :-)
A friend of mine has done the same thing, except with web logs.
Mostly so he can watch where his children go, however the same
could be done about hackers. Only exception is if someone knows
about it. If they know about it, most likely they know someone
who has physical access. If it was a rootkit that got you, then
you are safe. I'm sure the rest should be obvious.

In a nutshell... Yes it can be done and is one of the safer
methods, but more paranoid (which can be a good thing :-)


If you desire to know the method to accomplish this, I would
be happy to give them to you.


Another method, that just popped to mind, is perhaps having
Some form of a network share somewhere to which only write access
Is granted. No on could list the files, no one could read the files
(except for admin of course!). I'm unsure if it's possible to allow
Only additions to files and no deletions... Just a thought.

Samba Masters> Would this be possible via samba?

--KM
