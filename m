Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWIYCRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWIYCRK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 22:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWIYCRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 22:17:10 -0400
Received: from static.88-198-34-102.clients.your-server.de ([88.198.34.102]:8894
	"EHLO sleon.dyndns.org") by vger.kernel.org with ESMTP
	id S964801AbWIYCRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 22:17:08 -0400
From: Roman Glebov <sleon@sleon.dyndns.org>
Reply-To: sleon@sleon.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: megaraid question
Date: Mon, 25 Sep 2006 04:17:41 +0200
User-Agent: KMail/1.9.1
References: <20060925012909.A56E52963F@sleon.dyndns.org> <20060925015126.GA8764@animx.eu.org>
In-Reply-To: <20060925015126.GA8764@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609250417.41995.sleon@sleon.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 25. September 2006 03:51 schrieb Wakko Warner:
> Keep me in CC.
>
> sleon@sleon.dyndns.org wrote:
> > i am using opensource megaraid driver (2.6.17) . Do you know any
> > opensource monitoring tool for the opensource megaraid drivers Or is
> > there a way to check the state of harddrives connected to the megaraid
> > controller?
>
> I'd like to add a "ME TOO" here.  as well as one for the adaptec raid
> cards.
>
> Last time I looked, the only software I could find for megaraid was a
> program from Dell (binary only unfortunately)
Hi, thanks for answering me!

If i find something out i will let you know.
THe last info i got is that it is somehow possible with smartmon tools.
(a la smartctl -d megaraid,0 /dev/sda)

I am asking smartmontools developers right now, because there is no out of the 
box support for megaraid.

Also i was told that there is a binary monitoring tool from lsi-logic page.

But will it work with open source driver?

Roman
