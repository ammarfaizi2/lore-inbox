Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUBNUeG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbUBNUeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 15:34:06 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:47634 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263244AbUBNUeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 15:34:02 -0500
Date: Sat, 14 Feb 2004 17:54:56 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as189) Fix incorrect Appletalk DDP multicast address
Message-ID: <20040214205456.GD6533@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0402121613150.649-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0402121613150.649-100000@ida.rowland.org>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 12, 2004 at 04:24:48PM -0500, Alan Stern escreveu:
> Arnaldo:
> 
> This error has been present in the Appletalk network stack for as long
> as I can remember; it's a little surprising that nobody has fixed it yet.  

Its my fault, somebody sent me this fix already, but I didn't applied it
at the time, then forgot, I'll do this as soon as I get back to kernel work,
now I'm way busy with real life(tm) :-\

Thanks for the patch!

- Arnaldo
