Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUANANR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUANALh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:11:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3791 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266207AbUANAKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:10:16 -0500
Date: Tue, 13 Jan 2004 16:03:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Raj <obelix123@toughguy.net>
Cc: pidhash@yahoo.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: about ipmr
Message-Id: <20040113160318.02de40ab.davem@redhat.com>
In-Reply-To: <3FFE4D23.5030400@toughguy.net>
References: <20040109053433.3812.qmail@web12609.mail.yahoo.com>
	<3FFE4D23.5030400@toughguy.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jan 2004 12:11:39 +0530
Raj <obelix123@toughguy.net> wrote:

> I would prefer this way of checking the NULL
> 
> That would be more consistent with ip_gre.c and ipip.c

Patch applied, thank you.
