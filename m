Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbTFMSav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265475AbTFMSav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:30:51 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17092 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265470AbTFMSau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:30:50 -0400
Date: Fri, 13 Jun 2003 11:42:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: James Bourne <jbourne@hardrock.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-uv1 patch released
Message-Id: <20030613114249.6769b3fc.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0306131232460.9166-100000@cafe.hardrock.org>
References: <Pine.LNX.4.44.0306131232460.9166-100000@cafe.hardrock.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003 12:37:30 -0600 (MDT) James Bourne <jbourne@hardrock.org> wrote:

| Hi all,
| I've placed the update version 1 (2.4.21-uv1) patch at
| http://www.hardrock.org/kernel/current-updates/ for those who require it.
| 
| The current version contains only the NFS silly rename patch as posted for
| -rc7 and the updated of EXTRAVERSION.
| 
| Please send bug reports to jbourne@hardrock.org.

I can't boot 2.4.21 without the latest aic7xyz tarball applied,
from http://people.FreeBSD.org/~gibbs/linux/SRC/

The 2.4.21 driver just hangs during boot.

--
~Randy
