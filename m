Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSANVQc>; Mon, 14 Jan 2002 16:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289084AbSANVP7>; Mon, 14 Jan 2002 16:15:59 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:38155 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S289070AbSANVOW>; Mon, 14 Jan 2002 16:14:22 -0500
Date: Mon, 14 Jan 2002 22:14:08 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux india programming 
	<linux-india-programmers@lists.sourceforge.net>
Subject: Re: How to take a crash dump
Message-ID: <20020114211408.GB21480@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.10.10201041427001.2221-100000@blrmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201041427001.2221-100000@blrmail>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 02:30:20PM +0530, SATHISH.J wrote:
> I have "lcrash" installed on my system. I have 2.4.8 kernel. I would like
> to know how to make a linux system panic so that I can take a crash dump
> and analyse using "lcrash". Is there any command to make the system panis
> as we have on other unices(SVR4 and unixware)?

I wrote a toy module that does exactly what you want:

  http://www.lart.tudelft.nl/lartware/port/lart.c

I still have to get the module into Linus' tree so Christoph Hellwig
will drive to .nl to buy me a beer :)


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
