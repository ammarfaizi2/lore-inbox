Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261415AbSJ1N3d>; Mon, 28 Oct 2002 08:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSJ1N3d>; Mon, 28 Oct 2002 08:29:33 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:47582 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261415AbSJ1N3c>;
	Mon, 28 Oct 2002 08:29:32 -0500
Date: Mon, 28 Oct 2002 14:35:52 +0100
From: bert hubert <ahu@ds9a.nl>
To: buytenh@gnu.org, linux-kernel@vger.kernel.org
Subject: Silly advise in bridge Configure help
Message-ID: <20021028133552.GA15701@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, buytenh@gnu.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the Configure HELP of Ethernet bridging:

"Note that if your box acts as a bridge, it probably contains several
 Ethernet devices, but the kernel is not able to recognize more than one at
 boot time without help; for details read the Ethernet-HOWTO, available from
 in <http://www.linuxdoc.org/docs.html#howto>."

This is extremely bogus these days and prone to confuse people. I suggest
this warning is removed.

Kind regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
