Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318872AbSHWPSV>; Fri, 23 Aug 2002 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318873AbSHWPSV>; Fri, 23 Aug 2002 11:18:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:21496 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318872AbSHWPSU>; Fri, 23 Aug 2002 11:18:20 -0400
Subject: Re: [PATCH] Intel 830m backport (2.5 -> 2.4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Federico Di Gregorio <fog@initd.org>, faith@valinux.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020823153057.A18848@infradead.org>
References: <1030109549.1120.86.camel@momo> 
	<20020823153057.A18848@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 23 Aug 2002 16:23:05 +0100
Message-Id: <1030116185.5911.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 15:30, Christoph Hellwig wrote:

> Alan, is there any chance you could send marcelo the -ac drm code?

It needs untangling from any rmap macro dependancies. Go ahead 

