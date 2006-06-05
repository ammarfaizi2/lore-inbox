Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932442AbWFEHVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWFEHVs (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWFEHVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:21:48 -0400
Received: from gw.goop.org ([64.81.55.164]:35491 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932442AbWFEHVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:21:48 -0400
Message-ID: <4483DB86.2070908@goop.org>
Date: Mon, 05 Jun 2006 00:21:42 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org> <200606041347.26853.rjw@sisk.pl>
In-Reply-To: <200606041347.26853.rjw@sisk.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Well, this looks like a tough one.  Could you please create a bugzilla entry
> with all of the relevant information?
>   
OK, http://bugzilla.kernel.org/show_bug.cgi?id=6647

    J
