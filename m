Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263578AbRFNSCS>; Thu, 14 Jun 2001 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263574AbRFNSCH>; Thu, 14 Jun 2001 14:02:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32525 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263553AbRFNSBw>; Thu, 14 Jun 2001 14:01:52 -0400
Subject: Re: double entries in /proc/dri?
To: pawal@blipp.com (Patrik Wallstrom)
Date: Thu, 14 Jun 2001 19:00:07 +0100 (BST)
Cc: lm@bitmover.com (Larry McVoy), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106130659070.18749-100000@vic20.blipp.com> from "Patrik Wallstrom" at Jun 13, 2001 07:03:59 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AbPc-00052Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 12 Jun 2001, Larry McVoy wrote:
> 
The two dri directory thing is a dumb DRI bug thats been reported to the XFree
dri folks since before 2.4 even came out - and not yet fixed.

DRI in XFree 4.1.0 might fix it but its so fantastically warped, full of C
preprocesor abuse and not binary compatible that they quite honestly ought
to go and rewrite it before they consider submitting it anywhere.

Alan

