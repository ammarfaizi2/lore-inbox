Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWALSUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWALSUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWALSUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:20:09 -0500
Received: from mx.dt.lt ([84.32.38.8]:48850 "EHLO mx.dtiltas.lt")
	by vger.kernel.org with ESMTP id S932497AbWALSUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:20:07 -0500
Date: Thu, 12 Jan 2006 20:18:15 +0200
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: why sk98lin driver is not up-to date ?
To: linux-kernel@vger.kernel.org
cc: Reuben Farrelly <reuben-lkml@reub.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: INLINE
References: <Xns97496767C8536ericbelhommefreefr@80.91.229.5> <200601120339.17071.chase.venters@clientec.com>
 <43C63361.103@reub.net>
In-Reply-To: <43C63361.103@reub.net>
X-Mailer: Mahogany 0.66.0 'Clio', compiled for Linux 2.6.13-1.1532_FC4 i686
Message-Id: <20060112181844.D8EF9BAE5@mx.dtiltas.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 23:45:53 +1300 Reuben Farrelly <reuben-lkml@reub.net> wrote:

> Yes, look at the skge driver in 2.6.15 and the upcoming sky2 in 2.6.16.
> 
> I think you'll find those drivers much better than sk98lin and support most if 
> not all of the cards that the sk98lin driver works with.  Certainly those two 
> replacement drivers are better maintained.

Which one is better and what is a difference between them? Which one
will support Marvell Technology Group Ltd. 88E8050 Gigabit Ethernet Controller
(rev 17)? skge in 2.6.14 does not support it.

Regards,
Nerijus
