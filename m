Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946014AbWBOQfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946014AbWBOQfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946013AbWBOQfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:35:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56492 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1945993AbWBOQfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:35:14 -0500
Subject: Re: [linux-usb-devel] Re: Linux 2.6.16-rc3
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060215162720.GA1503@kroah.com>
References: <1139934883.14115.4.camel@mulgrave.il.steeleye.com>
	 <Pine.LNX.4.44L0.0602151103160.4598-100000@iolanthe.rowland.org>
	 <20060215162720.GA1503@kroah.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 17:35:08 +0100
Message-Id: <1140021308.4117.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 08:27 -0800, Greg KH wrote:
> 
> Nah, I don't think it's a good idea.  James's patch should work just
> fine.

another option is to have a "kill list" which you put the thing on, and
then wake up a thread. only 2 pointers in the object ;(


