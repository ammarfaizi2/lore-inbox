Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262729AbVCWRLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbVCWRLf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbVCWRLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:11:34 -0500
Received: from main.gmane.org ([80.91.229.2]:437 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262729AbVCWRLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:11:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Date: Wed, 23 Mar 2005 17:49:47 +0100
Message-ID: <MPG.1cabbc978b50163989719@news.gmane.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <20050314191230.3eb09c37.diegocg@gmail.com> <1110827273.14842.3.camel@mindpipe> <20050323013729.0f5cd319.diegocg@gmail.com> <1111539217.4691.57.camel@mindpipe> <20050323011313.GL15879@redhat.com> <MPG.1cab456fb7b20f93989718@news.gmane.org> <20050323161441.GA7994@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-11-253.37-151.net24.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What are the cons of using "all of" the RAM at boot time to 
> > cache the boot disk?

Dave Jones wrote:
> It's memory that's otherwise unused. Once you start using the system
> anything cached will get reclaimed as its needed.

So there is no substantial loss? IOW, it would suffice to have 
all the "loaded at boot" stuff in the first <amount of RAM>
bytes of the hard disk?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

