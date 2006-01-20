Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWATMwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWATMwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWATMwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:52:24 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7057 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750901AbWATMwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:52:20 -0500
Subject: Re: io performance...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D0626A.2090802@fastmail.co.uk>
References: <5vx8f-1Al-21@gated-at.bofh.it> <5wbRY-3cF-3@gated-at.bofh.it>
	 <5wdKh-5wF-15@gated-at.bofh.it> <43CEF263.9060102@shaw.ca>
	 <43CF90C6.8050505@fastmail.co.uk>
	 <1137679698.8471.30.camel@localhost.localdomain>
	 <43D0626A.2090802@fastmail.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 12:52:10 +0000
Message-Id: <1137761530.24161.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-20 at 12:09 +0800, Max Waterman wrote:
> I'm not sure what difference it makes if the controller is battery 
> backed or not; if the drives are gone, then the card has nothing to 
> write to...will it make the writes when the power comes back on?

Yes it will, hopefully having checked first before writing. The higher
end ones you can even pull the battery backed ram module out, change the
raid card and it will do it.

Alan

