Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbSLDDs4>; Tue, 3 Dec 2002 22:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSLDDs4>; Tue, 3 Dec 2002 22:48:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:55483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266876AbSLDDsz>;
	Tue, 3 Dec 2002 22:48:55 -0500
Date: Tue, 3 Dec 2002 19:53:15 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: James Stevenson <james@stev.org>
cc: Duncan Sands <baldrick@wanadoo.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: Reserving physical memory at boot time
In-Reply-To: <1038957801.13490.5.camel@god.stev.org>
Message-ID: <Pine.LNX.4.33L2.0212031952530.7246-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Dec 2002, James Stevenson wrote:

| On Tue, 2002-12-03 at 12:03, Duncan Sands wrote:
| > I would like to reserve a particular page of physical memory when
| > the kernel boots.  By reserving I mean that no one else gets to read
| > from it or write to it: it is mine.  Any suggestions for the best way
| > to go about this with a 2.5 kernel?
|
| try having a look for the linux badmem patches i belive they might do
| the same sort of thing.

see http://badmem.sourceforge.net/

-- 
~Randy

