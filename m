Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTDWIIl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 04:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTDWIIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 04:08:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20968 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263985AbTDWIIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 04:08:40 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 23 Apr 2003 10:20:39 +0200 (MEST)
Message-Id: <UTC200304230820.h3N8Kd501822.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, peter@chubb.wattle.id.au
Subject: Re: [PATCH] struct loop_info64
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it's *usually* better not to use int or long,
> but to use explicitly-sized types

The version that was committed by Linus only uses explicit types.

Andries

[I get requests for an additional field lo_size, so perhaps
this struct will still change a little.]
