Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTDXCHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTDXCHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:07:42 -0400
Received: from almesberger.net ([63.105.73.239]:2055 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264401AbTDXCHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:07:41 -0400
Date: Wed, 23 Apr 2003 23:19:20 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Pat Suwalski <pat@suwalski.net>, Matthias Schniedermeyer <ms@citd.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423231920.D1425@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <20030423221749.GA9187@elf.ucw.cz> <3EA71533.4090008@suwalski.net> <20030423225520.GA32577@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423225520.GA32577@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Thu, Apr 24, 2003 at 12:55:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> That breaks in init=/bin/bash siuations,

True. This also breaks a zillion other things, like NFS, journal
recovery, and such. Shouldn't we have kernel options for them as
well ? :-)

> old distros, etc.

So you're claiming that users will find it more difficult to add
one line to rc.local than upgrading their kernel ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
