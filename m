Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWFULhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWFULhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWFULhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:37:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38887 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751332AbWFULhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:37:19 -0400
Subject: Re: [PATCH] moxa: do not ignore input
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Organov <osv@javad.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       rmk+serial@arm.linux.org.uk
In-Reply-To: <87y7vrpwzr.fsf@javad.com>
References: <200506021220.47138.vda@ilport.com.ua>
	 <200506021554.07316.vda@ilport.com.ua>
	 <20050602225805.GB9628@devserv.devel.redhat.com>
	 <200506031601.21180.vda@ilport.com.ua>  <87y7vrpwzr.fsf@javad.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 12:51:44 +0100
Message-Id: <1150890705.15275.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 21:17 +0400, ysgrifennodd Sergei Organov:
> This is on 2.6.14 kernel though, -- didn't try with more recent kernels
> as I have other troubles with them on my hardware/distribution.
> 
> Not a big deal, but you've asked yourself ;)

What does "dmesg" show for the Oops that caused the segfault ?

