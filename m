Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVBQKaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVBQKaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 05:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVBQKaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 05:30:05 -0500
Received: from simmts12.bellnexxia.net ([206.47.199.141]:50129 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262260AbVBQK3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 05:29:54 -0500
Message-ID: <4428.10.10.10.24.1108636051.squirrel@linux1>
In-Reply-To: <e030fd01c5625a80b90382e69843213f@e18.physik.tu-muenchen.de>
References: <20050214020802.GA3047@bitmover.com>
    <58cb370e05021404081e53f458@mail.gmail.com>
    <20050214150820.GA21961@optonline.net>
    <20050214154015.GA8075@bitmover.com>
    <7579f7fb0502141017f5738d1@mail.gmail.com>
    <20050214185624.GA16029@bitmover.com>
    <1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp>
    <20050216154321.GB34621@dspnet.fr.eu.org>
    <4213E141.5040407@tequila.co.jp>
    <e9d587a22ff0b23ccbb6fa112377dbee@e18.physik.tu-muenchen.de>
    <42145128.4030202@tequila.co.jp>
    <e030fd01c5625a80b90382e69843213f@e18.physik.tu-muenchen.de>
Date: Thu, 17 Feb 2005 05:27:31 -0500 (EST)
Subject: Re: [BK] upgrade will be needed
From: "Sean" <seanlkml@sympatico.ca>
To: "Roland Kuhn" <rkuhn@e18.physik.tu-muenchen.de>
Cc: "Clemens Schwaighofer" <cs@tequila.co.jp>,
       "Olivier Galibert" <galibert@pobox.com>, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, February 17, 2005 4:27 am, Roland Kuhn said:

> The difference comes after the merge. Suppose Andrew didn't push
> everything to Linus. Then new patches come in, both trees change. In
> this situation it is very time consuming with subversion to work out
> the changes which still have to go from Andrew's tree to Linus' tree.

Since Andrew does this all by hand now, subversion / arch / whatever could
only improve the situation.  And the kicker is that using a free system
would mean the result could be dumped into BK for those that want to use
it.   The reverse unfortunately isn't true; not because of technical
reasons, but because of license restrictions.

Sean


