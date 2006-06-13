Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWFMQoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFMQoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWFMQoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:44:30 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:38626 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932085AbWFMQo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:44:29 -0400
Date: Tue, 13 Jun 2006 12:44:27 -0400
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Christian H?rtwig <christian.haertwig@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: How does RAID work with IT8212 RAID PCI card?
Message-ID: <20060613164427.GD560@csclub.uwaterloo.ca>
References: <200606131758.45704.christian.haertwig@gmx.de> <20060613160138.GC560@csclub.uwaterloo.ca> <305c16960606130920wa66c6bk504273a9a45e645e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960606130920wa66c6bk504273a9a45e645e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2006 at 01:20:55PM -0300, Matheus Izvekov wrote:
> No not true, i have this card and its a true hardware raid card. The
> thing is, this card has both a raid and a passthru mode, you should
> check which bios is flashed into it. Google is your friend.

Hmm, you would think that if the bios lets you setup a raid, then it
must have raid mode enabled then.  Or does it need a different driver to
work then?

Len Sorensen
