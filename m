Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTAaOVj>; Fri, 31 Jan 2003 09:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbTAaOVi>; Fri, 31 Jan 2003 09:21:38 -0500
Received: from [81.2.122.30] ([81.2.122.30]:32519 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261205AbTAaOVi>;
	Fri, 31 Jan 2003 09:21:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301311429.h0VETx2h001209@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 morse code panics
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 31 Jan 2003 14:29:59 +0000 (GMT)
Cc: davej@codemonkey.org.uk, szepe@pinerecords.com,
       linux-kernel@vger.kernel.org, arodland@noln.com
In-Reply-To: <1044025785.1654.13.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jan 31, 2003 03:09:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A lot of newer laptops do not have serial ports. While morse code may
> be a little silly the general purpose hook  it needs to be done 
> cleanly is considerably more useful

Exactly.

The exact method that a crashed machine, in a rack, in a datacentre,
miles away from me, contacts me to let me know something is wrong
doesn't matter, but if a member of the datacentre staff can get a
detailed message to me, so much the better than just having the box
rebooted.  On the other hand, I don't actually want to have to listen
to ten minutes of morse code over the phone when another box could do
it for me.

John.
