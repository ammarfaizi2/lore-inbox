Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSDNJg6>; Sun, 14 Apr 2002 05:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSDNJg5>; Sun, 14 Apr 2002 05:36:57 -0400
Received: from dns.uni-trier.de ([136.199.8.101]:57030 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S311871AbSDNJg5>; Sun, 14 Apr 2002 05:36:57 -0400
Date: Sun, 14 Apr 2002 11:36:54 +0200 (CEST)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: brian@worldcontrol.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Is 2.4.19-pre5-ac3 destroying my laptop?
In-Reply-To: <20020414054141.GA1867@top.worldcontrol.com>
Message-ID: <Pine.LNX.4.40.0204141133070.4965-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i checked, which chipset is used: its the via kt133a ...
this chipset should be supported by lvcool

mybee you could give this patch a try:
http://cip.uni-trier.de/nofftz/linux/

and report me, whether it works ...
(only works with acpi)

daniel



# Daniel Nofftz .......................... #
# Sysadmin CIP-Pool Informatik ........... #
# University of Trier(Germany), Room V 103 #

The resonable man adapts himself to the world. The unreasonable
man persists in trying to adapt the world to himself. It follows
that all progress depends on the unresaonable man.
                                        George Bernard Shaw

