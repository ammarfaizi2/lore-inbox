Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264297AbUHWNcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUHWNcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 09:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUHWNcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 09:32:13 -0400
Received: from serwer.tvgawex.pl ([212.122.214.2]:3065 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S264265AbUHWNcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 09:32:10 -0400
Date: Mon, 23 Aug 2004 15:32:08 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6.8.1 breaks tspc
Message-ID: <20040823133208.GA26915@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200408212303.05143.mail@earthworm.de> <200408221506.07883.mail@earthworm.de> <200408221743.22561.vda@port.imtp.ilyichevsk.odessa.ua> <200408221826.41842.mail@earthworm.de> <4129E782.3040409@fugmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4129E782.3040409@fugmann.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 12:48:02PM +0000, Anders Fugmann wrote:
> Christian Hesse wrote:
> >On Sunday 22 August 2004 16:43, Denis Vlasenko wrote:
> >
> >>Please try whether it works whan you do
> >>"echo 0 > /proc/sys/net/ipv4/tcp_window_scaling"
> >That helps. Thanks so far.
> Any explanation of why this solution works?
> 
> I hate to blindly just disable window_scaling, just to make tspc work on 
> 2.6.8.1.

 http://lwn.net/Articles/92727/
 
-- 
Tomasz Torcz               "Never underestimate the bandwidth of a station 
zdzichu@irc.-nie.spam-.pl    wagon filled with backup tapes." -- Jim Gray 

