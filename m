Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbWALUuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWALUuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWALUuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:50:08 -0500
Received: from mx.dt.lt ([84.32.38.8]:11241 "EHLO mx.dtiltas.lt")
	by vger.kernel.org with ESMTP id S1161260AbWALUuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:50:06 -0500
Date: Thu, 12 Jan 2006 22:43:44 +0200
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: sk98lin
To: linux-kernel@vger.kernel.org
cc: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: INLINE
References: <20060112180048.8A18EBC32@mx.dtiltas.lt>
 <20060112101843.0b0e159f@dxpl.pdx.osdl.net>
In-Reply-To: <20060112101843.0b0e159f@dxpl.pdx.osdl.net>
X-Mailer: Mahogany 0.66.0 'Clio', compiled for Linux 2.6.13-1.1532_FC4 i686
Message-Id: <20060112204844.2E721C9F7@mx.dtiltas.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 10:18:43 -0800 Stephen Hemminger <shemminger@osdl.org> wrote:

> While developing the skge and sky2 driver I discovered more problems and
> those got fixed in the mainline sk98lin driver.

What is a difference between them? Which one supports Marvell Technology
Group Ltd. 88E8050 Gigabit Ethernet Controller (rev 17)?
skge in 2.6.14 does not support it.

Regards,
Nerijus
