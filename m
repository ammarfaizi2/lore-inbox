Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbTCaIUg>; Mon, 31 Mar 2003 03:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbTCaIUg>; Mon, 31 Mar 2003 03:20:36 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:55277 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261460AbTCaIUg>;
	Mon, 31 Mar 2003 03:20:36 -0500
Date: Mon, 31 Mar 2003 10:31:57 +0200
From: bert hubert <ahu@ds9a.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030331083157.GA29029@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Roman Zippel <zippel@linux-m68k.org>,
	Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com> <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303281924530.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303281924530.5042-100000@serv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 07:48:13PM +0100, Roman Zippel wrote:

> If Andries would actually explain, what he wants to do with the larger 
> dev_t, it would be a lot easier to help him, so that we can at least avoid 
> the biggest mistakes.

Can you envision solutions based on 16 bit kdev_t infrastructure? 

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
