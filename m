Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317047AbSFFTKF>; Thu, 6 Jun 2002 15:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSFFTKE>; Thu, 6 Jun 2002 15:10:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9210 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317047AbSFFTKE>; Thu, 6 Jun 2002 15:10:04 -0400
Subject: Re: Promise Ultra100 hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: "Brian J. Conway" <bconway@WPI.EDU>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206062043470.6451-100000@sjoerd.sjoerdnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 21:03:32 +0100
Message-Id: <1023393812.23008.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 19:53, Arjan Filius wrote:
> Hello Brian,
> 
> Same issue here, 2.4.18 running fine with my new 160GB maxtor drive on a
> promise udma100 ide controller, 2.4.19-pre9 hangs on partition check at
> boot time.

Should be ok in pre10-ac2. I'll push Marcelo the change soon

