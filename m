Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSG2IuC>; Mon, 29 Jul 2002 04:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSG2IuB>; Mon, 29 Jul 2002 04:50:01 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56263 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S313558AbSG2IuB>;
	Mon, 29 Jul 2002 04:50:01 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 29 Jul 2002 10:53:16 +0200 (MEST)
Message-Id: <UTC200207290853.g6T8rGg29804.aeb@smtp.cwi.nl>
To: akpm@zip.com.au, util-linux@math.uio.no
Subject: Re: [util-linux] kernel profiler in 2.5.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +               if (*mode!='T' && *mode!='t' && *mode!='w' && *mode != 'W')

Thanks - applied.
Andries
