Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319604AbSIHNGQ>; Sun, 8 Sep 2002 09:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319605AbSIHNGQ>; Sun, 8 Sep 2002 09:06:16 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:31474
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319604AbSIHNGP>; Sun, 8 Sep 2002 09:06:15 -0400
Subject: Re: clean before or after dep?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Martin.Knoblauch@teraport.de
In-Reply-To: <Pine.LNX.4.44.0209072139470.21724-100000@redshift.mimosa.com>
References: <Pine.LNX.4.44.0209072139470.21724-100000@redshift.mimosa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 08 Sep 2002 14:13:02 +0100
Message-Id: <1031490782.26902.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now this seems to contradict
> 	<http://www.tldp.org/HOWTO/Kernel-HOWTO-2.html#ss2.3>
> which specifies, in step 5:
> 	bash# make dep
> 	bash# make clean
> 
> Which is the right order for clean and dep?

The "kernel-howto" has been badly broken for years. The world would
actually be better without that document IMHO

