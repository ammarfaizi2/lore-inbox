Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbTBGWq4>; Fri, 7 Feb 2003 17:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTBGWq4>; Fri, 7 Feb 2003 17:46:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18598
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266777AbTBGWqz>; Fri, 7 Feb 2003 17:46:55 -0500
Subject: Re: [PATCH] 2.5.59 : sound/oss/vidc.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Davis <fdavis@si.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.44.0302071211390.6917-100000@master>
References: <Pine.LNX.4.44.0302071211390.6917-100000@master>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044662081.15774.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Feb 2003 23:54:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 17:13, Frank Davis wrote:
> Hello all,
>    The following patch addresses buzilla bug # 318, and removes an
> offending semicolon. Please review for inclusion

This one was ok before. The indentation was wrong thats all

> 
