Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUAQEIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 23:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUAQEIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 23:08:40 -0500
Received: from main.gmane.org ([80.91.224.249]:25764 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265994AbUAQEIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 23:08:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
Date: Sat, 17 Jan 2004 05:08:36 +0100
Message-ID: <yw1xad4n6wu3.fsf@kth.se>
References: <20040117031925.GA26477@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:0K4Dc5bFXQAlV9RhYeT1/xQvEFQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Shannon Hendrix <shannon@widomaker.com> writes:

> Is CD burning supposed to work with kernel 2.6.1 using the ATAPI
> interface, or are bugs still being worked out?
>
> I have run cdrecord under kernel 2.4.2x and it worked great using the
> ATAPI interface like this:
>
> % cdrecord dev=ATAPI:bus,drive,lun

I use dev=/dev/hdc.  It haven't seen it fail once.

-- 
Måns Rullgård
mru@kth.se

