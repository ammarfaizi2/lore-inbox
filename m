Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVEPCKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVEPCKG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 22:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVEPCKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 22:10:06 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:60824 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261231AbVEPCKC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 22:10:02 -0400
Date: Mon, 16 May 2005 03:09:44 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
In-Reply-To: <20050515162059.GA26197@hh.idb.hist.no>
Message-ID: <Pine.LNX.4.62.0505160309150.27240@sheen.jakma.org>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
 <20050515162059.GA26197@hh.idb.hist.no>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2005, Helge Hafting wrote:

> 64-bit hardware is mainstream already.  Just get an amd processor,
> available in both stationary and portable models.  Even micoroft
> has noticed those, and linux support is old.
> 32-bit will hang on for a while longer in the form of old hardware,
> but not likely for another 33 years.

You don't need 64bit hardware for a 64bit time_t. 64bit time_t is 
perfectly viable on 32bit platforms.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
bureaucracy, n:
 	A method for transforming energy into solid waste.
