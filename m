Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTCPFUW>; Sun, 16 Mar 2003 00:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262402AbTCPFUW>; Sun, 16 Mar 2003 00:20:22 -0500
Received: from fmr01.intel.com ([192.55.52.18]:21189 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262394AbTCPFUW> convert rfc822-to-8bit;
	Sun, 16 Mar 2003 00:20:22 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780AFB144E@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "'Eli Carter'" <eli.carter@inet.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: kgdb (kernel debugger)
Date: Sat, 15 Mar 2003 21:31:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Martin

> > Has anyone looked into getting kgdb working on 2.5?  On any
> architecture?  (I'm mostly interested in XScale, but I thought I'd start
> here in the hope that another arch has done the heavy lifting. ;) )
> 
> It does already, it's in both current -mm and -mjb trees. There was a
> fancy new version floating around at one point, not sure what happened
> to that, but the old one works fine.

Is there a way to get a separate patch w/o the whole -mm? (I guess I can do
the required manual surgical separation, but asking is free :)

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

