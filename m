Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266448AbUGOXAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266448AbUGOXAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 19:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUGOXAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 19:00:53 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:15828 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266448AbUGOXAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 19:00:52 -0400
Date: Thu, 15 Jul 2004 16:00:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: christophe varoqui <christophe.varoqui@free.fr>
Cc: device-mapper development <dm-devel@redhat.com>,
       Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] Re: namespaces (was Re: [Q] don't allow tmpfs to page out)
Message-ID: <20040715230041.GA10969@taniwha.stupidest.org>
References: <1089878317.40f6392d7e365@imp5-q.free.fr> <20040715080017.GB20889@devserv.devel.redhat.com> <Pine.LNX.4.60.0407151329100.2622@fogarty.jakma.org> <20040715123148.GA23112@devserv.devel.redhat.com> <1089930946.6145.12.camel@zezette>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089930946.6145.12.camel@zezette>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 12:35:46AM +0200, christophe varoqui wrote:

> will execv() inherits the caller's namespace ?

yes
