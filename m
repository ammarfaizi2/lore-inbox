Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTDDREe (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTDDRE0 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:04:26 -0500
Received: from ip67-93-141-189.z141-93-67.customer.algx.net ([67.93.141.189]:61170
	"EHLO datapower.ducksong.com") by vger.kernel.org with ESMTP
	id S263861AbTDDQ6E (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 11:58:04 -0500
Date: Fri, 4 Apr 2003 12:09:29 -0500
From: "Patrick R. McManus" <mcmanus@ducksong.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Justin Cormack <justin@street-vision.com>, Paul Rolland <rol@as2917.net>,
       "'Michael Knigge'" <Michael.Knigge@set-software.de>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Strange e1000
Message-ID: <20030404170929.GA1461@ducksong.com>
References: <043501c2faaf$da061e10$3f00a8c0@witbe> <1049467531.2676.87.camel@lotte> <20030404154842.GA10607@gtf.org> <20030404170214.GA1457@ducksong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404170214.GA1457@ducksong.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I can confirm this is isolated to the managed netgear switches.. I
> started the other thread jeff mentions and, just this morning, cobbled
> together a network without them and had no problems. I'll see if I can
> create a setup without spanning tree to test that explicitly.

yes - turning off spanning tree on the netgear switches 'fixes' this
issue with the intel 1000 MT.

