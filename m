Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWAaQo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWAaQo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 11:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWAaQo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 11:44:27 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:48793 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751205AbWAaQo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 11:44:27 -0500
Date: Tue, 31 Jan 2006 16:43:43 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: j@bitron.ch, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43DF3C3A.nail2RF112LAB@burner>
Message-ID: <Pine.LNX.4.64.0601311639140.3920@sheen.jakma.org>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <200  <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2006, Joerg Schilling wrote:

> What Linux does is to artificially prevent this view to been seen 
> from outside the Linux kernel, or to avoid integrating a particular 
> device into a unique SCSI driver system although it would be 
> apropriate.

So let's get this straight: Linux is artificially limiting userspace 
from viewing devices in terms of parallel SCSI address (B/T/L) 
because it does not create such B/T/L addresses, ones which would 
hence be *artificial* themselves, for non-parallel-SCSI devices?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
zeal, n.:
 	Quality seen in new graduates -- if you're quick.
