Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274979AbTHAXBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 19:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274980AbTHAXBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 19:01:10 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:40818 "EHLO
	arlx248.austin.ibm.com") by vger.kernel.org with ESMTP
	id S274979AbTHAXBJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 19:01:09 -0400
Subject: Re: HELP: cpufreq on HT and/or SMP systems
From: Wes Felter <wesley@felter.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1059778307.1537.173.camel@bip.parateam.prv>
References: <200307312353.54735.gallir@uib.es>
	 <pan.2003.08.01.22.36.19.940443@felter.org>
	 <1059778307.1537.173.camel@bip.parateam.prv>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: Hack the Planet
Message-Id: <1059778865.23307.42.camel@arlx248.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 01 Aug 2003 18:01:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-01 at 17:51, Xavier Bestel wrote:
> Le sam 02/08/2003 à 00:36, Wes Felter a écrit :
> > AFAIK no SMP systems have voltage/frequency scaling (SpeedStep/PowerNow).
> > I've heard that ACPI P-states works on SMP, but if it's not doing
> > voltage/frequency scaling then I don't know what it's doing.
> 
> I've got an ABit VP6 (VIA686, dual P3), and the processors speed and
> voltage can be set in the BIOS. Does it count ?

I meant dynamic voltage/frequency scaling, so that doesn't count.

Wes Felter - wesley@felter.org - http://felter.org/wesley/
