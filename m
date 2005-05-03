Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVECOaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVECOaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVECOae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:30:34 -0400
Received: from ns.suse.de ([195.135.220.2]:30618 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261689AbVECO3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:29:08 -0400
Date: Tue, 3 May 2005 16:28:58 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Christopher Warner <chris@servertogo.com>, Andi Kleen <ak@suse.de>,
       Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050503142858.GZ7342@wotan.suse.de>
References: <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com> <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine> <20050502203359.GR23013@shell0.pdx.osdl.net> <20050502210839.GB2230@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502210839.GB2230@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 05:08:39PM -0400, Dave Jones wrote:
> On Mon, May 02, 2005 at 01:33:59PM -0700, Chris Wright wrote:
>  > * Christopher Warner (chris@servertogo.com) wrote:
>  > > Actually I am testing your patches. Its just going to take some time.
>  > > The problem occurs under severe load and I'm in the process of doing
>  > > load testing this for an inhouse app this week. Soon as i'm able to send
>  > > debug information I will.
>  > 
>  > Same here.  I've just never found a way to trigger other than wait.
> 
> *nod*, the current test-kernel update for Fedora also has your
> debugging patches, but none of the users have hit them (or reported
> them) yet.

The second version with the WARN_ON? If not please update to that one.

-Andi
