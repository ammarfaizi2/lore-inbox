Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVCIBAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVCIBAY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 20:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCIBAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 20:00:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:4485 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbVCIA46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:56:58 -0500
Date: Tue, 8 Mar 2005 16:53:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-Id: <20050308165345.32c14e3b.akpm@osdl.org>
In-Reply-To: <20050309001604.GC3146@stusta.de>
References: <20050308033846.0c4f8245.akpm@osdl.org>
	<20050309001604.GC3146@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Tue, Mar 08, 2005 at 03:38:46AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.11-mm1:
> >...
> > -fix-buggy-ieee80211_crypt_-selects.patch
> > 
> >  Was wrong.
> >...
> 
> I'd say my patch was correct.

Uh, OK.  Make that "was subject of interminable bunfight".

Feel free to resend and I'll keep spamming Jeff with it.
