Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422958AbWBAVqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422958AbWBAVqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422959AbWBAVqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:46:06 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:17297 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1422958AbWBAVqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:46:04 -0500
Date: Wed, 1 Feb 2006 21:45:51 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Albert Cahalan <acahalan@gmail.com>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <787b0d920601312107k31542295vb0bdee4bb2a67a39@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602012141420.3920@sheen.jakma.org>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> 
 <43D7A7F4.nailDE92K7TJI@burner>  <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
  <43D7B1E7.nailDFJ9MUZ5G@burner>  <20060125230850.GA2137@merlin.emma.line.org>
  <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> 
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>  <43DF3C3A.nail2RF112LAB@burner>
  <Pine.LNX.4.64.0601311639140.3920@sheen.jakma.org>
 <787b0d920601312107k31542295vb0bdee4bb2a67a39@mail.gmail.com>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006, Albert Cahalan wrote:

> For Joerg's reference, open() goes like this:
>
> 1. the /dev name
> 2. the inode
> 3. the device number
> 4. pointers to structs full of function pointers
>
> Nowhere is it in B/T/L form.

And, for whatever it's worth, TTBOMK Solaris does not arrange SCSI 
into a B/T/L address hierarchy internally either.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Mystics always hope that science will some day overtake them.
 		-- Booth Tarkington
