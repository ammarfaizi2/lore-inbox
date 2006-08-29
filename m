Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWH2PwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWH2PwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 11:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWH2PwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 11:52:25 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:61574 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965041AbWH2PwY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 11:52:24 -0400
Date: Tue, 29 Aug 2006 08:46:45 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Greg KH <greg@kroah.com>
cc: Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060829024901.GA32426@kroah.com>
Message-ID: <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> 
 <1156803102.3465.34.camel@mulgrave.il.steeleye.com>  <20060828230452.GA4393@powerlinux.fr>
 <44F38BCE.2080108@flower.upol.cz>  <1156809344.3465.41.camel@mulgrave.il.steeleye.com>
  <44F3A355.6090408@flower.upol.cz> <20060829015103.GA28162@kroah.com> 
 <20060829031430.GA9820@flower.upol.cz> <20060829024901.GA32426@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006, Greg KH wrote:

> I think the current way we handle firmware works quite well, especially
> given the wide range of different devices that it works for (everything
> from BIOS upgrades to different wireless driver stages).

the current system works for many people yes, but not everyone.

I'm still waiting to find a way to get the iw2200 working without having to use 
modules.

there was a post a month or two ago from someone who had indicated they found a 
way to re-initialize it after the system came up, but after someone asked for 
details of how to do it there was no response.

David Lang
