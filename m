Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUIXO6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUIXO6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUIXO6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:58:47 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:39946 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268081AbUIXO6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:58:45 -0400
Message-ID: <41543786.5090107@techsource.com>
Date: Fri, 24 Sep 2004 11:04:38 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [DOC] Linux kernel patch submission format
References: <200409221947.i8MJlnSX003715@laptop11.inf.utfsm.cl>
In-Reply-To: <200409221947.i8MJlnSX003715@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Horst von Brand wrote:
> Timothy Miller <miller@techsource.com> said:
> 
>>Does the Linux kernel source tree include a shell script which will 
>>compare two trees, create patches, and ask the necessary questions so as 
>>to format the files correctly with all the right stuff?
> 
> 
> diff(1) does what you want...

So, in addition to producing the difference, diff also asks you all the 
questions necessary for a Linux kernel submission, properly formats 
them, and adds them to the diff output?

