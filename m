Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbTDVE5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 00:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbTDVE5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 00:57:22 -0400
Received: from fmr01.intel.com ([192.55.52.18]:18370 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262930AbTDVE5V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 00:57:21 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263852@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'karim@opersys.com'" <karim@opersys.com>
Cc: "'Tom Zanussi'" <zanussi@us.ibm.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Robert Wisniewski'" <bob@watson.ibm.com>
Subject: RE: [patch] printk subsystems
Date: Mon, 21 Apr 2003 22:09:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Karim Yaghmour [mailto:karim@opersys.com]
> 
> "Perez-Gonzalez, Inaky" wrote:
>
> > Not meaning to be an smartass here, but I don't buy the "lockless" tag,
> > I would agree it is an optimized-lock scheme ....
> >
> > Although it is not that important, no need to make a fuss out of that :)
> 
> I actually think this is important.

Don't get me wrong - I don't mean the actual difference is not important;
what I mean is not important is me buying the "lockless" tag or not. I 
actually think that the method you guys use is really sharp.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
