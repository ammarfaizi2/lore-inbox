Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293147AbSBWPoO>; Sat, 23 Feb 2002 10:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293148AbSBWPoE>; Sat, 23 Feb 2002 10:44:04 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:4020 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S293147AbSBWPn7>; Sat, 23 Feb 2002 10:43:59 -0500
Date: Sat, 23 Feb 2002 16:43:53 +0100
From: bert hubert <ahu@ds9a.nl>
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
Message-ID: <20020223164353.B1952@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"Paul G. Allen" <pgallen@randomlogic.com>,
	Linux kernel developer's mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C771D29.942A07C2@starband.net>, <3C771D29.942A07C2@starband.net> <20020223134053.4fbe25ed.gang_hu@soul.com.cn> <3C772EF4.DB49876F@zip.com.au> <3C775FEF.BDA0253C@randomlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C775FEF.BDA0253C@randomlogic.com>; from pgallen@randomlogic.com on Sat, Feb 23, 2002 at 09:27:21AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 09:27:21AM +0000, Paul G. Allen wrote:

> Which compiler, of all of the different versions, generates the most
> stable and fastest code. Compile speed and kernel size is not NEARLY as
> important as performance. So, which compiler fits the bill?

GCC 3.1, is what I'm told. 3.x has the infrastructure to do more optimizing,
but doesn't do all of it yet. 3.1 is supposed to.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
