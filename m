Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbTCaNGC>; Mon, 31 Mar 2003 08:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbTCaNGC>; Mon, 31 Mar 2003 08:06:02 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:12972 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261623AbTCaNGB>;
	Mon, 31 Mar 2003 08:06:01 -0500
Date: Mon, 31 Mar 2003 15:17:23 +0200
From: bert hubert <ahu@ds9a.nl>
To: Marci <voloterreno@tin.it>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: APM: The system doesn't standby or suspend
Message-ID: <20030331131723.GA5628@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Marci <voloterreno@tin.it>, lkml <linux-kernel@vger.kernel.org>
References: <3E883640.4010400@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E883640.4010400@tin.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 02:36:16PM +0200, Marci wrote:
> Hi all, when I try to put the system in standby mode or suspend mode by 
> APM with the command apm -s or apm -S in the console I see the HDs that 
> powers off , and the monitor powers off too, but after few seconds the 
> system awakes automatically from the suspend mode (or standby) .

Many modern machines do not implement APM well anymore. Try ACPI. Does it
work with other kernels?

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
