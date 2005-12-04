Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVLDMdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVLDMdL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 07:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVLDMdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 07:33:10 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:27531 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932203AbVLDMdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 07:33:09 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: fix cpufreq-ondemand by accounting skipped ticks as idle ticks [Was: [PATCH] i386 no idle HZ aka Dynticks 051203]
Date: Sun, 4 Dec 2005 23:32:47 +1100
User-Agent: KMail/1.9
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       Adam Belay <abelay@novell.com>, Daniel Petrini <d.pensator@gmail.com>,
       vatsa@in.ibm.com
References: <200512041737.07996.kernel@kolivas.org> <20051204122434.GB9503@dominikbrodowski.de>
In-Reply-To: <20051204122434.GB9503@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512042332.49235.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 December 2005 23:24, Dominik Brodowski wrote:
> Account ticks skipped dynamically as idle ticks.
>
> This allows the ondemand cpufreq governor to work correctly with dyntick.

I never got around to studying it well enough to figure out how to fix it. 
Thanks very much! 

Cheers,
Con
