Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTLCDni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 22:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTLCDni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 22:43:38 -0500
Received: from codepoet.org ([166.70.99.138]:59287 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S264496AbTLCDnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 22:43:35 -0500
Date: Tue, 2 Dec 2003 20:43:37 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Joe Blow <joeblow341@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise 20378 + 2.6.0-test10 + libata patch 1
Message-ID: <20031203034337.GA14398@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Joe Blow <joeblow341@hotmail.com>, linux-kernel@vger.kernel.org
References: <BAY7-F83MLR6utNNYUR00004e92@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY7-F83MLR6utNNYUR00004e92@hotmail.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 03, 2003 at 03:10:10AM +0000, Joe Blow wrote:
> >From: Erik Andersen <andersen@codepoet.org>
> >What exactly is needed to get got SATA and PATA support
> >comparable to the driver provided by promise?  Would it be
> >possible to adapt the existing promise PATA IDE driver to drive
> >the PATA port, while the libata Promise driver handles the SATA
> >ports.  Or would a new driver be needed?
> 
> Is there actually a Promise supplied driver that might work with the 20378 
> and PATA drives?  Someone sent me a .zip file with an open source driver 
> from Promise dated 02/20/03 but it's for 2.4.x.  I emailed Promise asking 
> if there was an update, and they denied it even existed.

http://www.promise.com/support/download/download2_eng.asp?productId=97&category=driver&os=4
http://www.promise.com/support/file/driver/1_SATALINUXSRC1.00.0.8.zip

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
