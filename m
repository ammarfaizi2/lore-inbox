Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUI1WTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUI1WTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUI1WRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:17:01 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:51148 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268082AbUI1WQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:16:46 -0400
Date: Wed, 29 Sep 2004 00:15:20 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Robert White <rwhite@casabyte.com>
Cc: "'Nigel Cunningham'" <ncunningham@linuxmail.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Chris Wright'" <chrisw@osdl.org>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040928221520.GF4084@dualathlon.random>
References: <20040925012705.GC3309@dualathlon.random> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAM/+M3vc36kiUY6px1It1rQEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAM/+M3vc36kiUY6px1It1rQEAAAAA@casabyte.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 03:03:44PM -0700, Robert White wrote:
> (Stupid Idea Warning... 8-)
> 
> The top-n reasons (mentioned) to want to have your swap encrypted involve things like
> dealing with a stolen/sold drive or someone using a boot CD to peak into your swapped

The stolen/sold drive is a subset of the stolen/sold laptop/desktop
instead. In such case they would get access to all your hardware info.
