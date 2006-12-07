Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937877AbWLGA5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937877AbWLGA5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937878AbWLGA5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:57:50 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:48260 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937877AbWLGA5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:57:49 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200612070057.kB70vDex019555@turbo.physics.adelaide.edu.au>
Subject: Re: 2.6.19-rt3: compilation failure
To: dwalker@mvista.com
Date: Thu, 7 Dec 2006 11:27:13 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1165451943.30279.2.camel@dwalker1.mvista.com> from "Daniel Walker" at Dec 06, 2006 04:39:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> On Thu, 2006-12-07 at 10:58 +1030, Jonathan Woithe wrote:
> > Upon an attempt to compile 2.6.19-rt3 I encountered the following compile
> > error:
> 
> This was fix in -rt5 or 6 I think . The !PREEMPT_RT case. Current
> version is -rt7

Ah right, good.  I did grab rt6 yesterday but forgot to bring it home.
That'll learn me. :)

Regards
  jonathan
