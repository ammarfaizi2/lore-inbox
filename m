Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbUA1Ph6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUA1Ph6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:37:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:37609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266008AbUA1Php (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:37:45 -0500
Date: Wed, 28 Jan 2004 07:32:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm1
Message-Id: <20040128073237.6e53d999.rddunlap@osdl.org>
In-Reply-To: <20040127233402.6f5d3497.akpm@osdl.org>
References: <20040127233402.6f5d3497.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 23:34:02 -0800 Andrew Morton <akpm@osdl.org> wrote:

| ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/
| 
| 
| - From now on, -mm kernels will contain the latest contents of:
| 
| 	Linus's tree:		linus.patch
| 	The ACPI tree:		acpi.patch
| 	Vojtech's tree:		input.patch
| 	Jeff's tree:		netdev.patch
| 	The ALSA tree:		alsa.patch
| 
|   If anyone has any more external trees which need similar treatment,
|   please let me know.

About kernel-janitors patches:

Do you want to continue reviewing/merging the KJ patches one by one
or just grab the complete patchset?

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
