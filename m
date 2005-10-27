Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVJ0NFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVJ0NFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 09:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVJ0NFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 09:05:32 -0400
Received: from [81.2.110.250] ([81.2.110.250]:56207 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750732AbVJ0NFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 09:05:31 -0400
Subject: Re: Kernel Panic + Intel SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Marcio Oliveira <moliveira@rhla.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0510270839130.9512@chaos.analogic.com>
References: <435FC886.7070105@rhla.com>
	 <Pine.LNX.4.61.0510261523350.6174@chaos.analogic.com>
	 <4360261E.4010202@rhla.com> <436026F2.1030206@rhla.com>
	 <Pine.LNX.4.61.0510270839130.9512@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Oct 2005 14:34:32 +0100
Message-Id: <1130420072.10604.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-10-27 at 08:49 -0400, linux-os (Dick Johnson) wrote:
> This is all 'Fedora' stuff, not Linux stuff. You should upgrade
> your 'mkinitrd' (or rewrite it) so it doesn't use Fedora-specific
> stuff if you intend to install an un-patched kernel.

Fedora is quite happy with an unpatched kernel, that is generally what I
am running for development on Fedora.

If you are using LVM2 or MD you just need to be sure you have the right
config options enabled (the Red Hat src.rpm is a good guide).

Alan

