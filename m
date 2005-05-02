Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVEBUNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVEBUNZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVEBUNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:13:25 -0400
Received: from mout.perfora.net ([217.160.230.40]:62920 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S261747AbVEBUNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:13:22 -0400
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
From: Christopher Warner <chris@servertogo.com>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       cwarner@kernelcode.com, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050502170042.GJ7342@wotan.suse.de>
References: <20050414181015.GH22573@wotan.suse.de>
	 <20050414181133.GA18221@wotan.suse.de>
	 <20050414182712.GG493@shell0.pdx.osdl.net>
	 <20050415172408.GB8511@wotan.suse.de>
	 <20050415172816.GU493@shell0.pdx.osdl.net>
	 <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
	 <20050419133509.GF7715@wotan.suse.de>
	 <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com>
	 <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com>
	 <20050502170042.GJ7342@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 02 May 2005 11:28:49 -0400
Message-Id: <1115047729.19314.1.camel@jasmine>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I am testing your patches. Its just going to take some time.
The problem occurs under severe load and I'm in the process of doing
load testing this for an inhouse app this week. Soon as i'm able to send
debug information I will.

-Christopher Warner

On Mon, 2005-05-02 at 19:00 +0200, Andi Kleen wrote:
> > Datapoint: exactly the same model as my workstation which showed
> > this problem recently.
> 
> FYI
> 
> Since all the people who run into this are refusing to test my 
> debugging/test patches (no feedback at all for them so far) I give up on this 
> now.
> 
> -Andi
> 

