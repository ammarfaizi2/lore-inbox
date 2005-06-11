Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVFKTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVFKTxo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVFKTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:53:44 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17906 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261801AbVFKTxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:53:35 -0400
Date: Sat, 11 Jun 2005 12:53:23 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
cc: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <1118519067.5593.22.camel@sdietrich-xp.vilm.net>
Message-ID: <Pine.LNX.4.10.10506111252060.13863-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2005, Sven-Thorsten Dietrich wrote:
> 
> Daniel's original patch MADE it optional. Its just that the code is
> apparently more complex looking that way, so its cleaner to do what Ingo
> did.
> 

We need the test coverage too, if there is a problem we're more likly to
find it if everyone runs with it on.

Daniel

