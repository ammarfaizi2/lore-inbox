Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262039AbSI3McQ>; Mon, 30 Sep 2002 08:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSI3McQ>; Mon, 30 Sep 2002 08:32:16 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:9722 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262039AbSI3McP>; Mon, 30 Sep 2002 08:32:15 -0400
Subject: Re: IDE patch for 2.4.19?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rodney Gordon II <meff@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020930034147.GA3431@spherenet.dyndns.org>
References: <20020930034147.GA3431@spherenet.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 13:44:18 +0100
Message-Id: <1033389858.16468.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 04:41, Rodney Gordon II wrote:
> Can anyone point me to a patch for 2.4.19 that is just the IDE changes
> in the ac series that effects the ICH3M chipset and UDMA 3/4/5 settings?
> Someone replied to my last post and said that this was merged in around
> ac3 .. I'd really appreciate it :)

There isnt one, there won't be one. Its too hard to seperate out most of
the work being done. The only change I have pushed to Marcelo is the
i845G chipset setup

