Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWHAI4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWHAI4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWHAI4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:56:12 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:5055 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932287AbWHAI4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:56:12 -0400
Date: Tue, 1 Aug 2006 10:53:43 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jonathan Matthews-Levine <matthewslevine@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: do { } while (0) question
Message-ID: <20060801085343.GC9589@osiris.boeblingen.de.ibm.com>
References: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com> <404c96810608010145r4c109fdet9eadba7090321048@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404c96810608010145r4c109fdet9eadba7090321048@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:45:26AM +0100, Jonathan Matthews-Levine wrote:
> On 01/08/06, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> >---
> >Always use do {} while (0).  Failing to do so can cause subtle compile
> >failures or bugs.
> >---
> >
> >I'm really wondering what these subtle compile failures or bugs are.
> >Could you please explain?
> 
> http://kernelnewbies.org/FAQ/DoWhile0

My question was referring to empty do { } while (0)'s... that's something
the FAQ is not dealing with :)
