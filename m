Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUJISDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUJISDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJISDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:03:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49361 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267165AbUJISDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:03:11 -0400
Date: Sat, 9 Oct 2004 12:51:56 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Martins Krikis <mkrikis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-pre4
Message-ID: <20041009155156.GA23965@logos.cnet>
References: <bc8bcc5104100909425b84579a@mail.gmail.com> <20041009170406.68545.qmail@web13723.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041009170406.68545.qmail@web13723.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 10:04:06AM -0700, Martins Krikis wrote:
> Marcelo,
> 
> > Here goes 2.4.28-pre4...
> 
> Congratulations on that.
> 
> > From now on can now change only what is necessary and let
> > the 2.4 tree in peace :)
> 
> Does this mean that there is no hope for adding iswraid to 
> the 2.4 kernel?
> http://prdownloads.sourceforge.net/iswraid/2.4.28-pre3-iswraid.patch.gz?download
> It still applies cleanly to 2.4.28-pre4 as well... Please consider.

Martins,

New drivers are OK, as long as they dont break existing setups, 
and if substantial amount of users will benefit from it.

You've submitted the patch to this list for review already? 
Can't remember from the top of my head.

A review by someone with good knowledge on this area (arjan, 
bart, alan, ?) would also be a good point on getting it into the
tree.
