Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423165AbWJaMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423165AbWJaMvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 07:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWJaMvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 07:51:35 -0500
Received: from holoclan.de ([62.75.158.126]:55248 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1423143AbWJaMvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 07:51:33 -0500
Date: Tue, 31 Oct 2006 13:47:47 +0100
From: Martin Lorenz <martin@lorenz.eu.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
Message-ID: <20061031124747.GG27390@gimli>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
	"Randy.Dunlap" <rdunlap@xenotime.net>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <45462591.7020200@ce.jp.nec.com> <Pine.LNX.4.64.0610300834060.25218@g5.osdl.org> <454637BE.6090309@ce.jp.nec.com> <Pine.LNX.4.64.0610300953150.25218@g5.osdl.org> <20061030183522.GL27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030183522.GL27968@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Mon, Oct 30, 2006 at 07:35:22PM +0100, Adrian Bunk
	wrote: > On Mon, Oct 30, 2006 at 10:16:34AM -0800, Linus Torvalds wrote:
	[...] > Martin, Michael, can you send complete "dmesg -s 1000000" for
	both > 2.6.18.1 and a non-working 2.6.19-rc kernel after resume? > I
	don't have high hopes, but perhaps looking at the dmesg and/or >
	diff'ing them might give a hint. > there are quite a few outputs from
	different kernels on my webpage www.lorenz.eu.org/~mlo/kernel/?C=M;O=D
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 07:35:22PM +0100, Adrian Bunk wrote:
> On Mon, Oct 30, 2006 at 10:16:34AM -0800, Linus Torvalds wrote:
[...]
> Martin, Michael, can you send complete "dmesg -s 1000000" for both 
> 2.6.18.1 and a non-working 2.6.19-rc kernel after resume?
> I don't have high hopes, but perhaps looking at the dmesg and/or 
> diff'ing them might give a hint.
> 
there are quite a few outputs from different kernels on my webpage
www.lorenz.eu.org/~mlo/kernel/?C=M;O=D

I hope I can go deeper into that tonight, but at the moment I can't promise
anything.


gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
