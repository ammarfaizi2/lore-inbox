Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTFBHLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTFBHLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:11:30 -0400
Received: from [62.29.66.239] ([62.29.66.239]:37248 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S261970AbTFBHL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:11:29 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Martin Schlemmer <azarah@gentoo.org>
Subject: Re: [PATCH] include/linux/sysctl.h needs linux/compiler.h
Date: Mon, 2 Jun 2003 10:24:12 +0300
User-Agent: KMail/1.5.9
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       LKML <linux-kernel@vger.kernel.org>
References: <3ED8D5E4.6030107@cox.net> <200306011136.27211.kde@myrealbox.com> <1054532617.5270.4.camel@workshop.saharacpt.lan>
In-Reply-To: <1054532617.5270.4.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200306021024.12861.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 June 2003 08:43, Martin Schlemmer wrote:
> The solution is to have a set of API headers that userspace can use,
> and that the kernel headers in turn include.
>
Yeah that would be great.
> Problem now (as usual), is that even though I and a few others did
> offer to help or organise help if one kernel hacker is willing to take
> the lead, nobody responded, so I guess we will not see this any time
> soon.
>
No glibc,binutils for us then.


Regards,
/ismail
