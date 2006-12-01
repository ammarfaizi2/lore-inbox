Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161815AbWLAVUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161815AbWLAVUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161771AbWLAVUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:20:08 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:21144 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161815AbWLAVUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:20:06 -0500
Message-ID: <45709C8A.1010701@drzeus.cx>
Date: Fri, 01 Dec 2006 22:20:10 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
References: <4564640B.1070004@indt.org.br> <45680308.4040809@drzeus.cx> <456AEC16.3010009@indt.org.br>
In-Reply-To: <456AEC16.3010009@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> ext Pierre Ossman wrote:
>>
>> This definition makes them look like bits, which is not how they are
>> used.
>
> How can I improve this? Defining using integers directly?
>

Precisely.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

