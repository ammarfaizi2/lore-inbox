Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVEMXey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVEMXey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbVEMXdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:33:42 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:2453 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262630AbVEMXdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:33:09 -0400
Date: Sat, 14 May 2005 00:32:40 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Andi Kleen <ak@muc.de>
cc: "Richard F. Rebel" <rrebel@whenu.com>, Gabor MICSKO <gmicsko@szintezis.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <20050513190549.GB47131@muc.de>
Message-ID: <Pine.LNX.4.62.0505140030130.27240@sheen.jakma.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de>
 <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005, Andi Kleen wrote:

> No, i strongly disagree on that. The reasonable thing to do is to 
> fix the crypto code which has this vulnerability, not break a 
> useful performance enhancement for everybody else.

Already done:

http://www.openssl.org/news/secadv_20030317.txt

This is old news it seems, a timing attack that has long been known 
about and fixed.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
What happens when you cut back the jungle?  It recedes.
