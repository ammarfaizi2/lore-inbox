Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSJEPBk>; Sat, 5 Oct 2002 11:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbSJEPBk>; Sat, 5 Oct 2002 11:01:40 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:55975 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262363AbSJEPBk>;
	Sat, 5 Oct 2002 11:01:40 -0400
Date: Sat, 5 Oct 2002 17:07:15 +0200
From: bert hubert <ahu@ds9a.nl>
To: jbradford@dial.pipex.com
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: 2.5.x and 8250 UART problems
Message-ID: <20021005150715.GA30761@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	jbradford@dial.pipex.com, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk
References: <200210051506.g95F6jfL000423@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210051506.g95F6jfL000423@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2002 at 04:06:45PM +0100, jbradford@dial.pipex.com wrote:

> I've noticed that 8250 UART based serial port performance is poorer in
> 2.5.x than 2.4.x and 2.2.x, on a couple of my machines.
> 
> The 486 SX-20 with 4 MB RAM, running 2.2.21 reliably achieves about 650
> BPS download from another machine, with the port runnnig at 9600 bps. 
> With 2.5.40, many characters are lost at 9600, making, e.g. a ZModem
> transfer retry for almost every block.

Have you tried 'hdparm -u'?
> 

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
