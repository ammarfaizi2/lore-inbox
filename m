Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270496AbUJUG0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270496AbUJUG0V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270421AbUJTT2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:28:48 -0400
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:24255 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S270278AbUJTTUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:20:55 -0400
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Bogus MCE upon resumption of system?
Date: Wed, 20 Oct 2004 15:20:46 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200410101932.12431.shawn.starr@rogers.com> <200410200454.16439.shawn.starr@rogers.com> <20041020154854.GF26439@elf.ucw.cz>
In-Reply-To: <20041020154854.GF26439@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410201520.46957.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend to RAM,  haven't gotten around to rebuilding kernel with USB not 
compiled in.

Can anyone verify this is a bogus MCE? it occurs only after resuming from 
suspend from RAM.

Shawn.

On October 20, 2004 11:48, Pavel Machek wrote:
> Ahoj!
>
> > MCE: The hardware reports a non fatal, correctable incident occurred on
> > CPU 0. Bank 1: f200000000000105
> >
> > Of note, when resume I see this MCE, though i suspect it is bogus upon
> > resume.
>
> You did not tell me if it was suspend-to-disk or -to-RAM. Also you'd
> better mail lkml... I know a little about MCEs.
>
>         Pavel
