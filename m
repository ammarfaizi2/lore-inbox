Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSL1QaK>; Sat, 28 Dec 2002 11:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSL1QaK>; Sat, 28 Dec 2002 11:30:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47626 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265098AbSL1QaK>;
	Sat, 28 Dec 2002 11:30:10 -0500
Date: Sat, 28 Dec 2002 16:38:28 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: John Bradford <john@grabjohn.com>
Cc: Stephen Satchell <list@fluent2.pyramid.net>, linux-kernel@vger.kernel.org
Subject: Re: Want a random entropy source?
Message-ID: <20021228163828.GI721@gallifrey>
References: <5.2.0.9.0.20021228073445.01d386c0@fluent2.pyramid.net> <200212281600.gBSG0P4r001160@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212281600.gBSG0P4r001160@darkstar.example.net>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 16:37:23 up 3 days, 23:03,  2 users,  load average: 0.03, 0.04, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Bradford (john@grabjohn.com) wrote:
> 
> I have never understood how a 16-bit DAC or ADC can have noise above
> 96 dB.  Surely _by definition_ a 16-bit DAC or ADC is one that does
> not have noise above that level.

Simple; the ADC might (ha - if you are lucky) have a nice low noise
figure; but its on a cheap sound card in a PC with god knows how much
other mush, with a cheap PSU with a piece of string connecting it to the 
CDROM and loads of other crap.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
