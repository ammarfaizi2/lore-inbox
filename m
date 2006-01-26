Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWAZNyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWAZNyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWAZNyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:54:45 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:19680 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751344AbWAZNyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:54:44 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 14:53:44 +0100
To: matthias.andree@gmx.de, acahalan@gmail.com
Cc: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D468.nailE2X41JL7B@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
 <20060126081940.GA13125@merlin.emma.line.org>
In-Reply-To: <20060126081940.GA13125@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> On Wed, 25 Jan 2006, Albert Cahalan wrote:
>
> > It's misleading to say that MacOS doesn't allow a file
> > descriptor. MacOS has something similar to what Linux
> > has, but not in the normal filesystem namespace. You
> > specify a name to get a handle. Of course, on MacOS,
> > Joerg also uses -scanbus to create nonsense.
>
> OK, so Jörg created this "nonsense", i. e. a triple of stupid numbers,
> and claims he's using them to provide device lists to applications.

More than 2/3 of all current OS use this way of adressing and it is 
a standard: (CAM).

> Well, in PeeCees, the BIOS presents that list of primary/secondary
> master/slave, so there's /some/ point in it. Once hotplug comes into
> play, it's all vain though.

Hotplug is only a problem when implemented in a sub-optimal way.
Please have a look at Solaris for hot plug support with stable interface 
names.... 

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
