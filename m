Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbUBAXeb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 18:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUBAXeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 18:34:31 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:19847
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265505AbUBAXea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 18:34:30 -0500
Date: Sun, 1 Feb 2004 18:47:07 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Paul Jakma <paul@clubi.ie>
Cc: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>,
       Christian Borntraeger <kernel@borntraeger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
Message-ID: <20040201184707.A15269@animx.eu.org>
References: <Pine.LNX.4.44.0402012314310.6574-100000@midi> <Pine.LNX.4.58.0402012235270.1071@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.58.0402012235270.1071@fogarty.jakma.org>; from Paul Jakma on Sun, Feb 01, 2004 at 10:36:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.0? 2.2 has been out more than long enough for boxes running such 
> kernels to have rolled over several times already.

Definately, I have a 2.2.13 box that's rolled 3 times.  I have to use utmp
to get the uptime.

[wakko@rod:/home/wakko] last -xf /var/run/utmp runlevel
runlevel (to lvl 5)                    Thu Nov 18 22:36 - 18:48 (1535+20:12)

utmp begins Thu Nov 18 22:36:07 1999
[wakko@rod:/home/wakko] 
  6:49pm  up 44 days, 15:23h,  3 users,  load average: 0.00, 0.00, 0.00
[wakko@rod:/home/wakko] 

It is firewalled by the way.
  
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
