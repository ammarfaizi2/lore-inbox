Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbTINS4h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbTINS4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 14:56:37 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:27808 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261236AbTINS4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 14:56:36 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Justin Cormack <justin@street-vision.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030914190121.G3371@pclin040.win.tue.nl>
References: <1063484193.1781.48.camel@mulgrave>
	 <20030913212723.GA21426@gtf.org>
	 <1063538182.1510.78.camel@lotte.street-vision.com>
	 <20030914190121.G3371@pclin040.win.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063565701.2149.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sun, 14 Sep 2003 19:55:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-14 at 18:01, Andries Brouwer wrote:
> I do not understand your complaint.

I sort of do - several vendor installers use fixed labels so
two installs on the same box get very confused. I've seen
novices tie themselves in knots with it before. That isn't
a problem with LABEL=, its an implementation issue with the
vendors install tools, and Red Hat certainly is one of the
parties that made this mistake.

Alan
