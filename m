Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSHDQzj>; Sun, 4 Aug 2002 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSHDQzj>; Sun, 4 Aug 2002 12:55:39 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:56056 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318182AbSHDQzi>; Sun, 4 Aug 2002 12:55:38 -0400
Subject: Re: Bug at page_alloc.c:183
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Victor Bogado da Silva Lins <victor@bogado.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1028479242.2599.28.camel@victor.bogado>
References: <1028479242.2599.28.camel@victor.bogado>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 19:17:18 +0100
Message-Id: <1028485038.14196.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 17:40, Victor Bogado da Silva Lins wrote:
> Aug  4 12:44:59 victor kernel: invalid operand: 0000
> Aug  4 12:44:59 victor kernel: CPU:    0
> Aug  4 12:44:59 victor kernel: EIP:    0010:[<c0130031>]    Tainted: P

Take it up with Nvidia or duplicate the problem on a box that has never
had the module loaded from a cold boot onwards

