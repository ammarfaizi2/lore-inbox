Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271400AbTGQMZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 08:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271421AbTGQMZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 08:25:38 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:43184 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S271400AbTGQMZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 08:25:36 -0400
Date: Thu, 17 Jul 2003 13:39:47 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Jens Axboe <axboe@suse.de>, Valdis.Kletnieks@vt.edu, vojtech@suse.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030717123946.GA571@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Martin Schlemmer <azarah@gentoo.org>, Jens Axboe <axboe@suse.de>,
	Valdis.Kletnieks@vt.edu, vojtech@suse.cz,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <200307161710.h6GHAsU1001493@turing-police.cc.vt.edu> <20030716171706.GN833@suse.de> <20030716175534.GA25712@suse.de> <1058422511.1164.1440.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058422511.1164.1440.camel@workshop.saharacpt.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 08:15:11AM +0200, Martin Schlemmer wrote:

 > > For info, I just tried cdda2wav, and whilst it used less CPU than
 > > cdparanoia, the dancing mouse effect still occurs 8-(
 > Stupid question:

Very stupid. [just kidding.. 8-)] 

 > the PS/2 and the ide channel is not maybe sharing an irq,

I answered this in my first mail, no it isn't.

 >or some ACPI weirdness of a kind ?

Not tried without ACPI. I'll give it a shot if I get time before
heading off to the airport..

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
