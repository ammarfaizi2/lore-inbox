Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268602AbTBZCMz>; Tue, 25 Feb 2003 21:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbTBZCMz>; Tue, 25 Feb 2003 21:12:55 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:40461 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S268602AbTBZCMz>; Tue, 25 Feb 2003 21:12:55 -0500
Date: Tue, 25 Feb 2003 20:23:10 -0600 (CST)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200302260223.h1Q2NAW41915@sullivan.realtime.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate warnings in generated module files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Feb 2003, Rusty Russell wrote:
>
> __optional should always be __attribute__((__unused__)), and
> __required should be your __attribute_used__. 

How about __keep or __needed  ?

milton
