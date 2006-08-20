Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWHTRzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWHTRzT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWHTRzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:55:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23234 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751095AbWHTRzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:55:17 -0400
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060819234629.GA16814@openwall.com>
References: <20060819234629.GA16814@openwall.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Aug 2006 19:15:17 +0100
Message-Id: <1156097717.4051.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-20 am 03:46 +0400, ysgrifennodd Solar Designer:
> Willy,
> 
> I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> into 2.4.34-pre.  (Last time I checked, 2.6 needed an equivalent fix,
> but I haven't produced one yet.)

Acked-by: Alan Cox <alan@redhat.com>

but should go into 2.6-mm and be tested in 2.6-mm before 2.4 backport.

