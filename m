Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbULFAvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbULFAvh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbULFAuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:50:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57611 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261439AbULFAse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:48:34 -0500
Date: Mon, 6 Dec 2004 01:48:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
Subject: Re: [2.6 patch] selinux: possible cleanups
Message-ID: <20041206004831.GM2953@stusta.de>
References: <20041128190139.GD4390@stusta.de> <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 10:54:56AM -0500, Stephen Smalley wrote:
>...
> - Did you mean to make avtab_insert static (you only removed the
> function prototype for it)?
>...

Yes, thanks for this corrections.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

