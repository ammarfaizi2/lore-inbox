Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSLDCaF>; Tue, 3 Dec 2002 21:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSLDCaF>; Tue, 3 Dec 2002 21:30:05 -0500
Received: from jstevenson.plus.com ([212.159.71.212]:47234 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S266841AbSLDCaE>;
	Tue, 3 Dec 2002 21:30:04 -0500
Subject: Re: Reserving physical memory at boot time
From: James Stevenson <james@stev.org>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212031303.16487.baldrick@wanadoo.fr>
References: <200212031303.16487.baldrick@wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 03 Dec 2002 23:23:21 +0000
Message-Id: <1038957801.13490.5.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 12:03, Duncan Sands wrote:
> I would like to reserve a particular page of physical memory when
> the kernel boots.  By reserving I mean that no one else gets to read
> from it or write to it: it is mine.  Any suggestions for the best way
> to go about this with a 2.5 kernel?

try having a look for the linux badmem patches i belive they might do
the same sort of thing.

	James


