Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265523AbTFRUfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265524AbTFRUfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:35:04 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:17424 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265523AbTFRUfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:35:00 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler starvation
Date: Wed, 18 Jun 2003 22:48:31 +0200
User-Agent: KMail/1.5.2
References: <200306182244.56920.gallir@uib.es>
In-Reply-To: <200306182244.56920.gallir@uib.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306182248.31308.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 June 2003 22:44, Ricardo Galli wrote:

Hi Ricardo,

> > Have you seen this email I just posted to lkml?
> > [PATCH] 2.5.72 O(1) interactivity bugfix
> > It may be affecting the scheduler in all sorts of ways.
>
> I've applied the patch you posted in your web page for 2.4.21-ck1. It feels
> more reactive but has an annoying collateral effect, it seems to slow down
> to new processes forked from an interactive program.
> I see it when selecting a PGP signed message in kmail, it takes up to two
> seconds to show the message body. The lag wasn't so noticeable before.
Robert already told so.

ciao, Marc

