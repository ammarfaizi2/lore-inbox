Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWAGEcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWAGEcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWAGEcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:32:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:23692 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932302AbWAGEct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:32:49 -0500
Subject: Re: request for opinion on synaptics, adb and powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Peter Osterlund <petero2@telia.com>, Luca Bigliardi <shammash@artha.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200601062317.03712.dtor_core@ameritech.net>
References: <20060106231301.GG4732@kamaji.shammash.lan>
	 <Pine.LNX.4.58.0601070053470.2702@telia.com>
	 <1136595097.4840.189.camel@localhost.localdomain>
	 <200601062317.03712.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 15:33:15 +1100
Message-Id: <1136608396.4840.206.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why would you want to switch to relative mode when leaving X? As far as
> I know the only other mouse "user" out there is GPM and there are patches
> available for it to use event device:
> 
> 	http://geocities.com/dt_or/gpm/gpm.html
> 
> Unfortunately the maintainer can't find time to merge these so they were
> sitting there for over 2 years. FWIW Fedora patches their GPM with these.

gpm among other legacy things ...

Ben.


