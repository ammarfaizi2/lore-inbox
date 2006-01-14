Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423233AbWANA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423233AbWANA2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423235AbWANA2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:28:47 -0500
Received: from web50106.mail.yahoo.com ([206.190.38.34]:58271 "HELO
	web50106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1423233AbWANA2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:28:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HYKhgLYifWsUZn+xvzEcC0Zq7Jq+Ecq46E40JfkMrr2VmHTAZLhYOvmVq2dY+iAXop625/vPvM6+Tq8VNmPygixv78xfmpjwRBA2sEWvsZh4Bgk2iSQR/WKKjli2sXF3sdzlMGcUYpehLs7ng12YszbBxUpaSulzHZTy/lF6obk=  ;
Message-ID: <20060114002843.41344.qmail@web50106.mail.yahoo.com>
Date: Fri, 13 Jan 2006 16:28:43 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: RE: machine check errors
To: "'don fisher'" <dfisher@as.arizona.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <EXCHG2003THfyQgeDKv00000c7e@EXCHG2003.microtech-ks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Download edac/bluesmoke from sourceforge and compile and install
> it, this will monitor ecc errors from linux, and should tell you
> if you are getting ecc errors.
> 

Download the bluesmoke from bluesmoke.sourceforge.net for now, as EDAC currently does not have the
Opteron driver yet. It is in the queue.

(EDAC is the name for the new module to be in the kernel shortly. Bluesmoke is the lagacy name for
EDAC)

doug t




"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

