Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290156AbSA3Qw3>; Wed, 30 Jan 2002 11:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290127AbSA3QvK>; Wed, 30 Jan 2002 11:51:10 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:24260 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290120AbSA3QuQ>; Wed, 30 Jan 2002 11:50:16 -0500
Date: Wed, 30 Jan 2002 18:45:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: TCP/IP Speed
In-Reply-To: <Pine.LNX.3.95.1020130114353.15469A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0201301844050.5518-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Richard B. Johnson wrote:

> The resolution is in microseconds. That's the specification. Not
> all 'codes' are exercised of course, but the resolution is sufficient
> to discern a 10 to 30 microsecond difference. I'm trying to measure
> milliseconds, well within its capability. FYI, this is what `ping`
> and `traceroute` use. It's fine.

Then you might wanna check whats going on in read and write, have you 
tried this with UDP too?

Cheers,
	Zwane Mwaikambo


