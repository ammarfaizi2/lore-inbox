Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTBABJ0>; Fri, 31 Jan 2003 20:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTBABJ0>; Fri, 31 Jan 2003 20:09:26 -0500
Received: from [198.73.180.252] ([198.73.180.252]:60745 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S264631AbTBABJ0> convert rfc822-to-8bit;
	Fri, 31 Jan 2003 20:09:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.59-mm7
Date: Fri, 31 Jan 2003 20:18:01 -0500
User-Agent: KMail/1.4.3
References: <20030131001733.083f72c5.akpm@digeo.com>
In-Reply-To: <20030131001733.083f72c5.akpm@digeo.com>
MIME-Version: 1.0
Message-Id: <200301312018.02020.tomlins@cam.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like something got missed...  I get this with mm7

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.59-mm7; fi
WARNING: /lib/modules/2.5.59-mm7/kernel/arch/i386/kernel/apm.ko needs unknown symbol xtime_lock

Ed Tomlinson

