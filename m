Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311471AbSCVJnG>; Fri, 22 Mar 2002 04:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311569AbSCVJm4>; Fri, 22 Mar 2002 04:42:56 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:35752 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311471AbSCVJmp>; Fri, 22 Mar 2002 04:42:45 -0500
Date: Fri, 22 Mar 2002 11:33:09 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Andre Hedrick <andre@linux-ide.org>
Cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3-ac5
In-Reply-To: <Pine.LNX.4.10.10203220125450.9319-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0203221130320.2084-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Andre Hedrick wrote:

> I am trying to close all possible points where the double timer could
> happen.  The object is to isolate it to hardware behavior, and determine
> what the event sequence is which is committing the sin.

Out of interest, which other situations have you seen it happen? I'm only 
aware of the one.

> Once constrained, it goes to a lab where I have access to a 320 channel
> or 8 x 40 channel POD digital trace/recorder to map the HOST driver
> against the device(s) response.  This is a major pain in the debugging
> process but it will close the issue for good.

Bugs, like roaches, have a terrible habit of surviving the worst nuking 
you can possibly inflict ;)

Goodluck,
	Zwane


