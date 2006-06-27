Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWF0THQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWF0THQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWF0THP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:07:15 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:20882 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932535AbWF0THN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:07:13 -0400
Message-ID: <44A181EC.2010601@drzeus.cx>
Date: Tue, 27 Jun 2006 21:07:24 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2GB or 4GB SD support for Linux 2.6.17?
References: <b6a2187b0606252154i42b031c7tbc72235e5ad4313c@mail.gmail.com>
In-Reply-To: <b6a2187b0606252154i42b031c7tbc72235e5ad4313c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> I tried both 2GB and 4GB SD card on 2.6.17 and both failed. But 1GB
> works fine.
> 

Known issue and I have a patch sent for review with Russell.
Unfortunately, he has commitments elsewhere. So we have to be patient a
bit longer.

Rgds
Pierre
