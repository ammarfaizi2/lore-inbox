Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbTCLPva>; Wed, 12 Mar 2003 10:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbTCLPva>; Wed, 12 Mar 2003 10:51:30 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48836
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261744AbTCLPv3>; Wed, 12 Mar 2003 10:51:29 -0500
Subject: Re: bio too big device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: scott-kernel@thomasons.org
Cc: Andre Hedrick <andre@linux-ide.org>, axboe@suse.de,
       Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303120854.17410.scott-kernel@thomasons.org>
References: <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org>
	 <200303120854.17410.scott-kernel@thomasons.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047488997.22694.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 17:09:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 14:54, scott thomason wrote:
> Just so everyone knows...these aren't ancient drives I'm talking 
> about. One is a 30GB Maxtor 5T030H3, less than two years old 
> IIRC, and the other is a 30GB IBM-DTLA-307030 purchased about 
> six months ago.

The conversation drifted ontoa different issue, your drives are fine,
in your case you are hitting bugs in the 2.5.x md driver.

