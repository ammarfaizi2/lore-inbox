Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUICOzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUICOzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUICOzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:55:46 -0400
Received: from the-village.bc.nu ([81.2.110.252]:7828 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269056AbUICOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:55:45 -0400
Subject: Re: Crashed Drive, libata wedges when trying to recover data
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg Stark <gsstark@mit.edu>
Cc: Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <87d613tol4.fsf@stark.xeocode.com>
References: <87oekpvzot.fsf@stark.xeocode.com>
	 <4136E277.6000408@wasp.net.au> <87u0ugt0ml.fsf@stark.xeocode.com>
	 <1094209696.7533.24.camel@localhost.localdomain>
	 <87d613tol4.fsf@stark.xeocode.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094219609.7923.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 14:53:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 15:27, Greg Stark wrote:
> Well I still have a problem. It seems once this occurs that *every* further
> access generates the error.

If you are accessing it through the file system I'd expect that to an
extent.

> So while my machine isn't crippled once this happens, I still can't proceed
> with the recovery.

Is this true copying the raw device ?

Alan

