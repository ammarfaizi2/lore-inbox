Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271411AbTHHOoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271414AbTHHOoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:44:07 -0400
Received: from pwmail.procempa.com.br ([200.248.222.108]:54166 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S271411AbTHHOoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:44:03 -0400
Date: Fri, 8 Aug 2003 11:46:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: 2.4.22-rc1 FIFO bug still present
In-Reply-To: <1060346384.4933.34.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308081146470.8204-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 Aug 2003, Alan Cox wrote:

> On Mer, 2003-08-06 at 18:23, Rob van Nieuwkerk wrote:
> > Stephen C. Tweedie made a fix (see below) for it in May.
> > It has been in the Alan's -ac series since then and it works fine.
> 
> Certainly seems to be fine and it is a real bug. There is another unfixed
> one of the same form with tty drivers too

Applied. 

