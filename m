Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSGITtS>; Tue, 9 Jul 2002 15:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSGITtR>; Tue, 9 Jul 2002 15:49:17 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:55730 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313419AbSGITsY>; Tue, 9 Jul 2002 15:48:24 -0400
Date: Tue, 9 Jul 2002 22:54:37 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: ATAPI + cdwriter problem
Message-ID: <20020709195437.GA1834@sci.fi>
References: <000901c226ac$dec99b20$0501a8c0@Stev.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c226ac$dec99b20$0501a8c0@Stev.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 07:25:42PM +0100, James Stevenson wrote:
> Hi
> 
> i have  bunch of messages like these and a hung cd writer
 
I had a similar experience when trying my CD writer on pdc20265 and a
cmd649 based board. Sometimes a write goes fine, sometimes that error
comes up and you get a coaster. Writer is an LG GCE-8160B.  It works
fine on the VIA 686b however, except for certain speed related issues
(audio writes at > 8x make system unresponsive, data writes ok, more
in http://marc.theaimsgroup.com/?l=linux-kernel&m=101826880719379&w=2).

