Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbTFLOLC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 10:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTFLOLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 10:11:02 -0400
Received: from mail.ithnet.com ([217.64.64.8]:18705 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264828AbTFLOLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 10:11:00 -0400
Date: Thu, 12 Jun 2003 16:05:52 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: eric.valette@free.fr, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Message-Id: <20030612160552.770bd15e.skraw@ithnet.com>
In-Reply-To: <20030611211506.GD16164@fs.tum.de>
References: <3EE66C86.8090708@free.fr>
	<20030611211506.GD16164@fs.tum.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003 23:15:06 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:

> [...]
> The important thing is that this is inside a stable kernel series and an 
> update that makes things better for 100 people but makes things worse 
> for one person is IMHO bad since it's a regression for one person.

You cannot fulfill that in reality. Looking at the broad variety of software
out there you simply cannot know all the implications a simple bug fix may
have. There may well be boxes that rely on a broken code you just fixed. Only
god knows. So you sometimes simply have to do "the right thing"(tm) knowing
there will always be people who shoot you for it.

Regards,
Stephan
