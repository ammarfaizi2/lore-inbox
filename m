Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTD3ANq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 20:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTD3ANq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 20:13:46 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:47888 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262049AbTD3ANp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 20:13:45 -0400
Date: Wed, 30 Apr 2003 01:25:54 +0100
From: John Levon <levon@movementarian.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to return -E Linux 2.5.68
Message-ID: <20030430002553.GB93529@compsoc.man.ac.uk>
References: <20030429161128.3b8c762b.rddunlap@osdl.org> <20030430000236.GS10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430000236.GS10374@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Spam-Score: -30.7 (------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19AfQ5-000Fb8-Gc*b85iM3Ux8Bo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 01:02:36AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> 	* oprofile init on alpha should be returning negative in case of
> failure to follow the common conventions.

I noticed this yesterday and the change is in my tree already.

regards,
john
