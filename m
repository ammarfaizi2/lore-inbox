Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTJDJKa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 05:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTJDJKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 05:10:30 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:19341 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S261956AbTJDJK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 05:10:29 -0400
Date: Sat, 4 Oct 2003 11:10:18 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Harold Martin <cocoadev@earthlink.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test6 not powering down
Message-ID: <20031004091018.GA10456@k3.hellgate.ch>
Mail-Followup-To: Harold Martin <cocoadev@earthlink.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1065219390.1717.17.camel@silver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065219390.1717.17.camel@silver>
X-Operating-System: Linux 2.6.0-test6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Oct 2003 15:16:30 -0700, Harold Martin wrote:
> I'm running a PIII system and now when it reaches "Power down." in it's
> shutdown sequence the machine doesn't shut off like it did under 2.4.
> I'm not sure what info would be useful in finding out the cause so just
> ask me. Or maybe I'm just screwing option up, which isn't entirely
> unheard of... ;)

Turning off UP APIC support often helps.

Roger
