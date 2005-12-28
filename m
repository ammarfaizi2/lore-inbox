Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVL1GeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVL1GeE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVL1GeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:34:03 -0500
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:14996 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932468AbVL1GeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:34:02 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC] CPU scheduler: Simplified interactive bonus mechanism
Date: Wed, 28 Dec 2005 17:35:00 +1100
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
References: <43B22FBA.5040008@bigpond.net.au>
In-Reply-To: <43B22FBA.5040008@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512281735.00992.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005 05:24 pm, Peter Williams wrote:
> This patch implements a prototype version of a simplified interactive
> bonus mechanism.  The mechanism does not attempt to identify interactive

> ---
>
> Your comments on this proposal are requested.
>
> ---

If we're going to redo the interactivity estimator I happen to have a whole 
cpu scheduler design that is interactive by design without being a state 
machine that I've been hacking / maintining / debugging for 2 years that many 
people are already using in production...

Cheers,
Con
