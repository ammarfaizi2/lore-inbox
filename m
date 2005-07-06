Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbVGFW6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbVGFW6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVGFWzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:55:10 -0400
Received: from mailer.cwie.net ([209.188.8.200]:55991 "EHLO mailer.cwie.net")
	by vger.kernel.org with ESMTP id S262541AbVGFWxY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:53:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: reiser4 plugins
Date: Wed, 6 Jul 2005 15:54:09 -0700
Message-ID: <889A47B16278164FB657E0FFB1CAB8C7B729A7@hq-exchange.ccbill-hq.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: reiser4 plugins
Thread-Index: AcWCfTdsCjrUI2rzTuq82WD7PasgBQAAFMoQ
From: "Doug Wicks" <doug@ccbill.com>
To: "Hans Reiser" <reiser@namesys.com>, "David Masover" <ninja@slaphack.com>
Cc: "Hubert Chan" <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, <ross.biro@gmail.com>,
       <vonbrand@inf.utfsm.cl>, <mrmacman_g4@mac.com>,
       <Valdis.Kletnieks@vt.edu>, <ltd@cisco.com>, <gmaxwell@gmail.com>,
       <jgarzik@pobox.com>, <hch@infradead.org>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>,
       <zam@namesys.com>, <vs@thebsh.namesys.com>, <ndiller@namesys.com>,
       <vitaly@thebsh.namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I get off the mail list here? 

 
doug@cavecreek.com
 

-----Original Message-----
From: Hans Reiser [mailto:reiser@namesys.com] 
Sent: Wednesday, July 06, 2005 3:50 PM
To: David Masover
Cc: Hubert Chan; Alexander G. M. Smith; ross.biro@gmail.com;
vonbrand@inf.utfsm.cl; mrmacman_g4@mac.com; Valdis.Kletnieks@vt.edu;
ltd@cisco.com; gmaxwell@gmail.com; jgarzik@pobox.com; hch@infradead.org;
akpm@osdl.org; linux-kernel@vger.kernel.org; reiserfs-list@namesys.com;
zam@namesys.com; vs@thebsh.namesys.com; ndiller@namesys.com;
vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins

David Masover wrote:

> So, will the format change happen at mount time?  Will it need a
> special mount flag?  Will I need to use debugfs or some other offline
> tool?


First we make sure we have the right answer.  Have we solved the cycle
problem?  Can we run out of memory as Horst/Nikita suggest?

