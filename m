Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbTBTPgL>; Thu, 20 Feb 2003 10:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTBTPgL>; Thu, 20 Feb 2003 10:36:11 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:57583 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S265578AbTBTPgL>; Thu, 20 Feb 2003 10:36:11 -0500
Subject: Re: Adaptec drivers causing problem in RHL 8.0
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Sahani Himanshu <honeyuee@iitr.ernet.in>, linux-kernel@vger.kernel.org
In-Reply-To: <1316810000.1045754413@aslan.scsiguy.com>
References: <Pine.GSO.4.05.10302201550440.2763-100000@iitr.ernet.in>
	 <1316810000.1045754413@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045755948.1599.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 20 Feb 2003 16:45:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 16:20, Justin T. Gibbs wrote:
> > Hi All,
> > 
> > May be you will say that this has been answered somewhere, but I am not
> > really able to understand what to do?
> > 
> > I recently installed RHL 8.0 on a SGI1200 server. The server has 
> > "Adaptec AIC-7896 SCSI BIOS v2.20S1B1" installed.

iirc this is a 440GX-box-from-hell; you HAVE to use the SMP kernel on
those.. the UP kernel doesn't have working irq routing.
