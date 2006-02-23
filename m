Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWBWFaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWBWFaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 00:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBWFaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 00:30:21 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37894 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751363AbWBWFaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 00:30:20 -0500
Date: Thu, 23 Feb 2006 06:25:32 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cannot open initial console
Message-ID: <20060223052532.GN11380@w.ods.org>
References: <305c16960602221818h69de46cfpa06027b44c2e07e8@mail.gmail.com> <305c16960602222127v65dadb03q242e69dd1a7f4712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960602222127v65dadb03q242e69dd1a7f4712@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 02:27:30AM -0300, Matheus Izvekov wrote:
> On 2/22/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
> > Hi all
> >
> > When i tried kernel 2.6.15.4, i noticed i cant boot it, i get
> > "warning: cannot open initial console" then it reboots. I've searched
> > for it and found the breakage occurs from 2.6.15.1 to 2.6.15.2
> >
> > Before i start to bisect to find the culpirit, and as there were few
> > changes, anyone has a good guess about what broke it?
> >
> > Thanks all in advance.
> >
> 
> Actually, i dont even know what git tree i should be using for this...
> How can i get the individual patches for the 2.6.15.1 -> 2.6.15.2 transition?

   http://www.<country>.kernel.org/pub/linux/kernel/v2.6/incr/

Willy

