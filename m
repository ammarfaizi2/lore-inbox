Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312345AbSCYIEu>; Mon, 25 Mar 2002 03:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312348AbSCYIEk>; Mon, 25 Mar 2002 03:04:40 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:53466 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312345AbSCYIEY>; Mon, 25 Mar 2002 03:04:24 -0500
Date: Mon, 25 Mar 2002 09:53:24 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Dave Jones <davej@suse.de>
Cc: Boris Bezlaj <boris@kista.gajba.net>,
        kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mdacon.c minor cleanups
In-Reply-To: <20020324194254.A14465@suse.de>
Message-ID: <Pine.LNX.4.44.0203250951520.14794-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mdacon probe code doesn't seem to work well, if i have it compiled in 
it *always* detects an MDA card, even if there isn't one actually in the 
box. I can provide the dmesg if anyone's interested.

	Zwane


