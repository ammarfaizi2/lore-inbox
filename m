Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTDUXYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbTDUXYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:24:43 -0400
Received: from pointblue.com.pl ([62.89.73.6]:46345 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262680AbTDUXYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:24:41 -0400
Subject: Re: grsecurity in 2.5?
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Chris Wright <chris@wirex.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030421143849.A11883@figure1.int.wirex.com>
References: <20030421212501.GA30266@kroah.com>
	 <Pine.LNX.4.44.0304212335520.25621-100000@server.piarista-kkt.sulinet.hu>
	 <20030421143849.A11883@figure1.int.wirex.com>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1050968186.3065.16.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Apr 2003 00:36:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 22:38, Chris Wright wrote:
> * Zoltan NAGY (nagyz@piarista-kkt.sulinet.hu) wrote:
> > On Mon, 21 Apr 2003, Greg KH wrote:
> > 
> > > What's the status of that patch being ported to the LSM interface (which
> > > is already in 2.5)?
> > 
> > AFAIK there was a discussion about it, but i dont know what decision has 
> > born.. 
> 
> I don't think the grsecurity developers are motivated to port their work
> to LSM.  Patches are welcome of course ;-)
Maybe we should start to bring them piece by piece, fe. PaX first and
others. 
Question is not that will somebody do that, i am sure of that - grsec is
needed in 2.4 - and it will be needed in 2.6. Question is, if it will be
included in mainstream kernel release ?

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

