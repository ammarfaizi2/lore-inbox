Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUCVO14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 09:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUCVO14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 09:27:56 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:54488 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S261999AbUCVO1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 09:27:55 -0500
Date: Mon, 22 Mar 2004 15:27:31 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>, Chris Wedgwood <cw@f00f.org>,
       Frank Cusack <fcusack@fcusack.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux sync(2) wait?
In-Reply-To: <405ED755.2070301@stesmi.com>
Message-ID: <Pine.LNX.4.58.0403221523590.218@neptune.local>
References: <1C8xa-5lk-5@gated-at.bofh.it> <E1B54ub-00004H-OC@localhost>
 <20040322005953.GA12237@dingdong.cryptoapps.com> <405E611D.10008@nortelnetworks.com>
 <405ED755.2070301@stesmi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Stefan Smietanowski wrote:

> >> 20 minutes?!
> > He did say it was a magneto-optical drive.
> That's 400KiB/s you know - pretty slow.

Yes. It's almost exclusively used once per week for backup purposes.
Speed doesn't matter for that (about 400 MB of often changing data on
/home), reliability counts.

Data that doesn't really change (old kernel releases and such) is
also on MO, but that's "write once, than forget about it", so once
again speed doesn't matter that much.

-- 
Ciao,
Pascal
