Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVLTTqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVLTTqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVLTTqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:46:17 -0500
Received: from adicia.telenet-ops.be ([195.130.132.56]:64735 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751053AbVLTTqQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:46:16 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Daniel Petrini <d.pensator@gmail.com>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051221
Date: Tue, 20 Dec 2005 21:46:12 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
References: <200512210310.51084.kernel@kolivas.org> <200512201827.56387.lkml@kcore.org> <9268368b0512201139v1836c920iaa6bdc11bd8f4e15@mail.gmail.com>
In-Reply-To: <9268368b0512201139v1836c920iaa6bdc11bd8f4e15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512202146.12737.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 December 2005 20:39, Daniel Petrini wrote:
> Hi Jan,
>
> On 12/20/05, Jan De Luyck <lkml@kcore.org> wrote:
> > One thing I'm curious about (and haven't tested yet): does this also work
> > with S3 suspend to ram? Last dynticks I tried had issues with that...
>
> I'm testing suspend to ram and it is working normally with dyn-ticks.
> What kind of problems are you facing?

I am facing none :) I just was facing (with an earlier dyntick patch, around 
2.6.12.x) problems resuming with it. They seem to have been fixed 
completely :)

In X i'm around 180HZ with everything up and running. Nice :) Very good work 
everyone :)

Jan
-- 
Tu bi or not tu bi 

DICK -- Começo de musica brega -- DICK vale o céu azul ... 
