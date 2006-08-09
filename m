Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWHIDoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWHIDoj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWHIDoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:44:39 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:29872 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030445AbWHIDoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:44:39 -0400
Date: Wed, 9 Aug 2006 06:44:34 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060809034434.GA4665@rhun.haifa.ibm.com>
References: <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com> <20060807182047.GC26224@atjola.homenet> <20060808122234.GD5497@rhun.haifa.ibm.com> <20060808125652.GA5284@ucw.cz> <20060808131724.GE5497@rhun.haifa.ibm.com> <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com> <20060808134337.GF5497@rhun.haifa.ibm.com> <41840b750608080753v27a0ce16xf4da0ad177b08657@mail.gmail.com> <1155050380.5729.89.camel@localhost.localdomain> <41840b750608080833p6e7cfffx890f9c4732b93e73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608080833p6e7cfffx890f9c4732b93e73@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 06:33:25PM +0300, Shem Multinymous wrote:
> On 8/8/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >If the concern is just the naming then change it to end _trylock
> 
> We already have a thinkpad_ec_trylock() for the non-blocking
> variant.

thinkpad_ec_down_interruptible()?

Cheers,
Muli
