Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUDPVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263838AbUDPVpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:45:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:32680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263855AbUDPVpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:45:00 -0400
Date: Fri, 16 Apr 2004 14:39:45 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig missing help for character device
Message-Id: <20040416143945.343a5652.rddunlap@osdl.org>
In-Reply-To: <20040416130348.GA6879@atrey.karlin.mff.cuni.cz>
References: <20040416130348.GA6879@atrey.karlin.mff.cuni.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 15:03:48 +0200 Karel Kulhavy wrote:

| linux kernel 2.6.3
| make menuconfig -> Character Device
| missing < Help >.
| Displays < Help > for make menuconfig instead.

Yes, that's the way that it (currently) works at that menu level.
If you select "Character Devices", then you can (try to) get help
for each individual entry there.

Are you able to help by sending patches?

--
~Randy
