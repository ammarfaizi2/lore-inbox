Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTEWAis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbTEWAis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:38:48 -0400
Received: from ip68-4-255-84.oc.oc.cox.net ([68.4.255.84]:64130 "EHLO
	ip68-101-124-193.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id S263496AbTEWAir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:38:47 -0400
Date: Thu, 22 May 2003 17:51:49 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3
Message-ID: <20030523005149.GA2420@ip68-101-124-193.oc.oc.cox.net>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 07:19:38PM -0300, Marcelo Tosatti wrote:
> Arjan van de Ven <arjanv@redhat.com>:
>   o ioperm fix

If this is the same code that's in Red Hat's latest security errata, I
think this may be broken (makes some programs segfault). 2.5 seems fine.
I'll reply with more details (and/or file a RH Bugzilla report) later
today, after I double-check things in a more controlled environment.

-Barry K. Nathan <barryn@pobox.com>
