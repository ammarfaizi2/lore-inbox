Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVARPro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVARPro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVARPqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:46:42 -0500
Received: from [217.112.240.26] ([217.112.240.26]:45955 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S261328AbVARPgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:36:07 -0500
Message-ID: <41ED2CD4.B0502FD7@users.sourceforge.net>
Date: Tue, 18 Jan 2005 17:35:48 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: Paul Walker <paul@black-sun.demon.co.uk>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>, linux-crypto@nl.linux.org,
       James Morris <jmorris@redhat.com>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
References: <41EAE36F.35354DDF@users.sourceforge.net>
			 <41EB3E7E.7070100@tmr.com> <41EBD4D4.882B94D@users.sourceforge.net>
			 <1105989298.14565.36.camel@ghanima>
			 <20050117192946.GT7782@black-sun.demon.co.uk> <1105995889.14565.47.camel@ghanima>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:
> Nothing about kernel crypto is backdoored. If Ruusu thinks different, he
> should show me source code. Till then, treat it as FUD.

I have been submitting fix for this weakness to mainline mount (part of
util-linux package) since 2001, about 2 or 3 times a year. Refusing to fix
it for *years* counts as intentional backdoor.

You call it whatever you want. I call it backdoor.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
