Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVAHMEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVAHMEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 07:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVAHMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 07:04:05 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:27786 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S261852AbVAHMEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 07:04:02 -0500
Date: Sat, 8 Jan 2005 11:58:05 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@hibernia.jakma.org
To: Jim Nelson <james4765@cwazy.co.uk>
cc: Lee Revell <rlrevell@joe-job.com>,
       Norbert van Nobelen <Norbert@edusupport.nl>,
       Raphael Jacquot <raphael.jacquot@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: Open hardware wireless cards
In-Reply-To: <41DDB02C.1030205@cwazy.co.uk>
Message-ID: <Pine.LNX.4.61.0501081154330.27046@hibernia.jakma.org>
References: <20050105200526.GL5159@ruslug.rutgers.edu> 
 <20050106172438.GT5159@ruslug.rutgers.edu> <41DD8D71.7000708@imag.fr> 
 <200501062032.13513.Norbert@edusupport.nl> <1105045205.15823.4.camel@krustophenia.net>
 <41DDB02C.1030205@cwazy.co.uk>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Jim Nelson wrote:

> Open-source drivers would make it trivial to make the hardware operate beyond 
> its legal limits - and could potentially land them in trouble with the 
> FCC/whatever.

This doesnt hold up at all, because the *closed* vendor software for 
some 802.11? radios will give you option to set the 'country' (and 
hence power), eg Netgear WG602v2 (an ISL3893 running Linux + 
proprietary mini-RTOS for the 802.11 bits + proprietary Linux side 
drivers to communicate between the two.).

Also, doesnt the USA have higher limits than most other countries? So 
the problem if anything would arise in /other/ regulatory domains, 
not FCC/USA.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Democracy is the name we give the people whenever we need them.
 		-- Arman de Caillavet, 1913
