Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWECMnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWECMnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030179AbWECMnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:43:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030180AbWECMnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:43:39 -0400
Date: Wed, 3 May 2006 05:43:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Alejandro Bonilla" <abonilla@linuxwireless.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: snd_hda_intel on 2.6.16 (or higher)
Message-Id: <20060503054330.9962cbf4.akpm@osdl.org>
In-Reply-To: <20060426224924.M44901@linuxwireless.org>
References: <20060426224924.M44901@linuxwireless.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006 16:55:03 -0600
"Alejandro Bonilla" <abonilla@linuxwireless.org> wrote:

> Hi,
> 
> I reported some snd_hda_intel problem a month ago. I have been using 2.6.15-21
> perfectly, but with 2.6.16 or even git 2.6.17-rc2 it is still going like at
> 1.2x the speed it should go (1x is ok). You can notice Music will actually go
> faster and it may sometimes chipmonk.
> 
> Please let me know what exact info is required if interested. This is on a
> Compaq V2000 Ubuntu Dapper Drake up to date and with 2.6.15-X it has worked
> perfectly and still is, until 2.6.16 or higher is loaded.
> 

Added alsa-devel to cc.

If this doesn't get resolved within a few days, please raise a report at
bugzilla.kernel.org so we can keep track of it.  Or in the ALSA bug
tracking system if that's requested.

Thanks.
