Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbTI2Rzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTI2Ryx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:54:53 -0400
Received: from intra.cyclades.com ([64.186.161.6]:38032 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264005AbTI2RuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:50:06 -0400
Date: Mon, 29 Sep 2003 14:49:37 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@localhost.localdomain
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.22 ide-scsi problem.
In-Reply-To: <Pine.LNX.4.58.0309231315120.11291@p500>
Message-ID: <Pine.LNX.4.44.0309271338590.2874-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What do you mean with "barf" ? 

You get IO errors? 

On Tue, 23 Sep 2003, Justin Piszcz wrote:

> While executing two parallel burns, when one goes to finalize the disc,
> the other one barfs (each drive = Plextor 12/10/32a (buffer underrun
> protection)).
> 
> This has never occured with 2.4.[0-21].
> 
> What happened in 2.4.22 with IDE-SCSI/IDE stuff?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


