Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270686AbTHOTXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHOTXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:23:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:65179 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270686AbTHOTXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:23:32 -0400
Date: Fri, 15 Aug 2003 12:21:32 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Stephen Hemminger <shemminger@osdl.org>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kobject rename can take const char
In-Reply-To: <20030815112217.1c8c13e5.shemminger@osdl.org>
Message-ID: <Pine.LNX.4.33.0308151221240.974-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> kobject_rename doesn't change the name string.

Thanks, both applied.


	Pat

