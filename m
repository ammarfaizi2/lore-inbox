Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSHHAEh>; Wed, 7 Aug 2002 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSHHAEh>; Wed, 7 Aug 2002 20:04:37 -0400
Received: from pD9E231F8.dip.t-dialin.net ([217.226.49.248]:28899 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316795AbSHHAEh>; Wed, 7 Aug 2002 20:04:37 -0400
Date: Wed, 7 Aug 2002 18:07:45 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Jesse Barnes <jbarnes@sgi.com>, Rik van Riel <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <jmacd@namesys.com>, <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <E17cZJi-00050N-00@starship>
Message-ID: <Pine.LNX.4.44.0208071807320.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2002, Daniel Phillips wrote:
> Random gripe: don't all those do { } whiles look silly?  We need
> 
>    #define NADA do { } while (0)
> 
> or similar.

Call it nop.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

