Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTFRQtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTFRQtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:49:39 -0400
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:57352 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265375AbTFRQtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:49:32 -0400
Date: Wed, 18 Jun 2003 19:03:26 +0200 (CEST)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 Frame Buffer Problem
In-Reply-To: <Pine.LNX.4.44.0306181738590.24449-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.51L.0306181859360.9362@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0306181738590.24449-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003, James Simmons wrote:
> > > > i had compile kernel 2.5.71 with VESA support (disabled nvidia
> > > > driver , on boot some lines and dotes dancing around the screen !
> > > Hum. Like to see those bugs.
> > I've got similar problems on my matroxfb.
> Strange. I will see if I can duplicate this bug. Is the bug at boot time
> or is it present all the time?

All the time.

Everything looks fine at the beginning, but running i.e. 'top' causes the 
console is unreadable. I can make it readable for a while with simple 
switch between consoles.

I don't know if I described it ok - the best would be short *.avi of that, 
but I don't have any camera...

-- 
pozdr.  Pawe³ Go³aszewski 
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...
