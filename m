Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTLVCRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 21:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTLVCRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 21:17:03 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:62922 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S264294AbTLVCRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 21:17:01 -0500
Date: Sun, 21 Dec 2003 18:17:00 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Arnaud Fontaine <arnaud@andesi.org>, Mike Fedyk <mfedyk@matchmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
Message-ID: <20031222021659.GA4857@ip68-4-255-84.oc.oc.cox.net>
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 12:35:24AM +0100, Maciej Zenczykowski wrote:
> you did run memtest for a minimum dozen hours? sometimes it takes that 
> long to find errors...

On one machine (with a bad power supply, as it turned out) it took
memtest86 almost 18 hours to report an error. So 12 hours isn't enough
either.

(On a related note, one machine that I tested with mprime's Torture Test
<http://www.mersenne.org/> took I think close to 43 hours to show a
failure. In that case I don't know if the failure was the CPU or the
motherboard, because in the end both failed on that system.)

-Barry K. Nathan <barryn@pobox.com>
