Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbVIMO5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbVIMO5r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVIMO5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:57:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932653AbVIMO5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:57:46 -0400
Date: Tue, 13 Sep 2005 07:57:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
In-Reply-To: <Pine.LNX.4.58.0509130717360.3351@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509130755280.3351@g5.osdl.org>
References: <1126569577.25875.25.camel@defiant> <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org>
 <20050913033814.GA879@tbdnetworks.com> <Pine.LNX.4.58.0509130717360.3351@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Linus Torvalds wrote:
> 
> I bet this will fix it..

Btw, there's a third case of this in the hpt34x driver. I'll fix that one 
too.

		Linus
