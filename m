Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264999AbTFQXBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 19:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbTFQXBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 19:01:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:62873 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264999AbTFQXBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 19:01:51 -0400
Date: Tue, 17 Jun 2003 20:13:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BK PATCH] 2.4 ACPI update
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A1E6@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.55L.0306172009520.31986@freak.distro.conectiva>
References: <F760B14C9561B941B89469F59BA3A84725A1E6@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Grover, Andrew wrote:

> Hi Marcelo,
>
> I'd like to try again to get you to merge in the latest ACPI change into
> 2.4. I know it's a big patch but the identical code has been in 2.5 all
> along. BitKeeper has been a big help in allowing me to maintain such a
> big patch for so long, but the fact is that getting this in 2.4 would
> make my life and other maintainers' lives much easier.
>
> The ACPI code in 2.4 is very old and buggy. Even though the current code
> is not flawless, it is much much improved. Its inclusion would not
> affect anything at all for people who don't explicitly configure in ACPI
> support.

Andrew,

I've changed my mind with respect to the ACPI merge in 2.4.22.

I'm willing to do it in .22 timeline.

I feel its better if we do the merge in separate parts, not in a huge
patch.

What you think ?
