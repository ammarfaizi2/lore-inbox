Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUATWEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUATWEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:04:09 -0500
Received: from intra.cyclades.com ([64.186.161.6]:12674 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265835AbUATWEC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:04:02 -0500
Date: Tue, 20 Jan 2004 19:41:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Lukasz Trabinski <lukasz@trabinski.net>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       dwmw2@infradead.org
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.58L.0401201940470.29729@logos.cnet>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jan 2004, Lukasz Trabinski wrote:

> In article <Pine.LNX.4.58L.0401161207000.28357@logos.cnet> you wrote:
> >
> > Hi,
> >
> > Here goes -pre6.
> >
> > This release came out so quickly because -pre5 contains a deadly mistake
> > in one of the fs patches.
>
> SMP (2x2.66GHz Intel), with scsi aic79xx  with kernel -pre6 crashed after
> 3 days.
>
> No ooops in logs files or console.
> Output from console SysRq showTasks, showMem and showTasks you can see
> here:
>
> http://lukasz.eu.org/minicom.txt
> or here, if first will not work:
> http://www.pm.waw.pl/~lukasz/minicom.txt

Hi Lukasz,

Can you please run the output through ksymoops?
