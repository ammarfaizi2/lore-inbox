Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284500AbRLIWLG>; Sun, 9 Dec 2001 17:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284545AbRLIWK4>; Sun, 9 Dec 2001 17:10:56 -0500
Received: from shell.cyberus.ca ([216.191.240.114]:10748 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S284544AbRLIWKk>;
	Sun, 9 Dec 2001 17:10:40 -0500
Date: Sun, 9 Dec 2001 17:07:03 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: bert hubert <ahu@ds9a.nl>
cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
In-Reply-To: <20011209225350.A22512@outpost.ds9a.nl>
Message-ID: <Pine.GSO.4.30.0112091706000.6079-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Dec 2001, bert hubert wrote:

> On Sun, Dec 09, 2001 at 04:45:01PM -0500, jamal wrote:
> > > > Cant think of a straight way to do this .... Alexey would know,
> > >
> > > SO_PRIORITY. Or I did not follow you?
> >
> > So priority limits the size of skb->priority to be from 0..6; this wont
> > work with that check in cbq.
>
> No, only IP_TOS does so.
>

probaly ip precedence. Have you tried this or you are following what the
man pages say?

cheers,
jamal

