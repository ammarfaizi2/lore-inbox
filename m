Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131575AbRADSWu>; Thu, 4 Jan 2001 13:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbRADSWk>; Thu, 4 Jan 2001 13:22:40 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:40201 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S131161AbRADSWZ>; Thu, 4 Jan 2001 13:22:25 -0500
Date: Thu, 4 Jan 2001 18:21:58 +0000 (GMT)
From: "Dr. David Gilbert" <gilbertd@treblig.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Lang <david.lang@digitalinsight.com>,
        Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <E14EEfY-00067i-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0101041818410.16594-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Alan Cox wrote:

> > for crying out loud, even windows tells the users they need to shutdown
> > first and gripes at them if they pull the plug. what users are you trying
> > to protect, ones to clueless to even run windows?
>
> Clueless ?  Hardly. Every other appliance in the home you turn it off and it
> goes off. You turn it on and it comes on. You get confused you turn it off and
> on. Its the definitive model of how home appliances works and its how people
> expect them to work.

I can see both sides of the argument - consider your video - users can
switch that off without thinking; but really its off switch is soft and
actually unloads the tape from the heads first before switching off.

Having said that look at something like test equipments; you can just pull
the power on them - I don't think large scopes/logic analysers with discs
in have anything clever hardware wise to to a careful switch off.
(Some of these are running Win98 and some HP-UX these days with
journalling stuff in).

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
