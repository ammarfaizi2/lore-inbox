Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264735AbSKDQKv>; Mon, 4 Nov 2002 11:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSKDQKv>; Mon, 4 Nov 2002 11:10:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:54990 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S264735AbSKDQKu>; Mon, 4 Nov 2002 11:10:50 -0500
Date: Mon, 4 Nov 2002 16:18:22 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Horst von Brand <vonbrand@eeyore.valparaiso.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: What's left over. 
In-Reply-To: <200211030225.gA32P37c006245@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.44.0211041614320.9959-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Horst von Brand wrote:
> Hugh Dickins <hugh@veritas.com> said:
> 
> > It's a real worry that writing a crash dump to disk might stomp in the
> > wrong place, but I don't recall it ever happening in practice.  But
> > occasionally, yes, a dump was not generated at all, or not completed.
> 
> How do you test that? Not in some contrieved situation, under real crashes.

Sorry for being unclear: by "in practice" I meant "under real crashes" i.e.
I was referring more to what we heard back from users than my own testing.

Hugh

