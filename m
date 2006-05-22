Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWEVTp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWEVTp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWEVTp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:45:58 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:17425 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750834AbWEVTp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:45:57 -0400
Message-ID: <447214EF.50803@argo.co.il>
Date: Mon, 22 May 2006 22:45:51 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christian Trefzer <ctrefzer@gmx.de>
CC: Matthias Schniedermeyer <ms@citd.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Knutar <jk-lkml@sci.fi>, Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <20060522151303.GA4538@hermes.uziel.local> <1148312458.17376.54.camel@localhost.localdomain> <20060522154830.GA5344@hermes.uziel.local> <4471E39C.1070003@citd.de> <20060522194040.GC5995@hermes.uziel.local>
In-Reply-To: <20060522194040.GC5995@hermes.uziel.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2006 19:45:55.0656 (UTC) FILETIME=[573B7480:01C67DD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Trefzer wrote:
>
> Exactly, and since I cannot afford to buy one I'd have to build it
> myself using mainly car batteries. The most complex part would be to
> charge the batteries in a way that won't kill them over time. Building
> such stuff into the PSU after the secondary coil and AC/DC converter
> would save the double-conversion loss, therefore making this ideal for a
> single machine. But I'm still brainstorming, lacking both money and
> time.
>

Led/acid batteries are dangerous. Don't use them unless you know exactly 
what you are doing.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

