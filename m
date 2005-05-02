Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVEBRCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVEBRCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVEBRCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:02:18 -0400
Received: from mx1.suse.de ([195.135.220.2]:44991 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261538AbVEBRA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:00:58 -0400
Date: Mon, 2 May 2005 19:00:42 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, Christopher Warner <chris@servertogo.com>,
       Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
       Andi Kleen <ak@suse.de>, Chris Wright <chrisw@osdl.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Message-ID: <20050502170042.GJ7342@wotan.suse.de>
References: <20050414181015.GH22573@wotan.suse.de> <20050414181133.GA18221@wotan.suse.de> <20050414182712.GG493@shell0.pdx.osdl.net> <20050415172408.GB8511@wotan.suse.de> <20050415172816.GU493@shell0.pdx.osdl.net> <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com> <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429173216.GB1832@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Datapoint: exactly the same model as my workstation which showed
> this problem recently.

FYI

Since all the people who run into this are refusing to test my 
debugging/test patches (no feedback at all for them so far) I give up on this 
now.

-Andi

