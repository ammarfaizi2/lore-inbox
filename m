Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUISNhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUISNhR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 09:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269241AbUISNhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 09:37:16 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:32671 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S269129AbUISNhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 09:37:16 -0400
Date: Sun, 19 Sep 2004 15:15:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Kenneth =?iso-8859-1?Q?Aafl=F8y?= <lists@kenneth.aafloy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Via-Rhine WOL vs PXE Boot
Message-ID: <20040919131531.GA10030@k3.hellgate.ch>
Mail-Followup-To: Kenneth =?iso-8859-1?Q?Aafl=F8y?= <lists@kenneth.aafloy.net>,
	linux-kernel@vger.kernel.org
References: <200409172154.36550.lists@kenneth.aafloy.net> <200409180001.42332.lists@kenneth.aafloy.net> <20040918061331.GA12757@k3.hellgate.ch> <200409191452.51507.lists@kenneth.aafloy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409191452.51507.lists@kenneth.aafloy.net>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 14:52:51 +0200, Kenneth Aafløy wrote:
> > I'm afraid you will convince neither me nor the hardware with assumptions.
> 
> WOL still works fine, at least with my hardware, without that statement.

I have hardware that needs D3 for WOL to work. Gotta love this.

Roger
