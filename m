Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSHYKqN>; Sun, 25 Aug 2002 06:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSHYKqN>; Sun, 25 Aug 2002 06:46:13 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:58807 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317251AbSHYKqN>; Sun, 25 Aug 2002 06:46:13 -0400
Date: Sun, 25 Aug 2002 13:07:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Gerald Teschl <gerald@esi.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ad1848 causes infinite loop in 2.4.19 
In-Reply-To: <Pine.LNX.4.44.0208242219360.28661-100000@keen.esi.ac.at>
Message-ID: <Pine.LNX.4.44.0208251252590.28574-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2002, Gerald Teschl wrote:

> PS: My fix for the isapnp activation of the opl3sa4 card did not
> show up in the 2.4.19 kernel (with my patch the above problem
> will not occure). How do I find out the current status of my
> patches. Should I resubmit them? 

If they're in -ac, they will get pushed to mainline, alternatively you 
could attempt to send direct to Marcelo.

	Zwane

-- 
function.linuxpower.ca


