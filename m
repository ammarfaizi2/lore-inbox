Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVHCNMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVHCNMK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 09:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVHCNMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 09:12:10 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24039 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261970AbVHCNMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 09:12:07 -0400
Subject: Re: Segfaults in mkdir under high load. Software or hardware?
From: Steven Rostedt <rostedt@goodmis.org>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jules Colding <colding@omesc.com>
In-Reply-To: <20050803125752.GA2912@outpost.ds9a.nl>
References: <1123071243.6758.18.camel@omc-2.omesc.com>
	 <20050803125752.GA2912@outpost.ds9a.nl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 03 Aug 2005 09:12:00 -0400
Message-Id: <1123074720.1590.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 14:57 +0200, bert hubert wrote:
> I've seen errors like these happen, and they were kernel bugs.
> 
> > [    0.000000] Bootdata ok (command line is root=/dev/sda4 vga=0x31B video=vesafb:mtrr,ywrap)
> > [    0.000000] Linux version 2.6.12-gentoo-r6 (root@omc-2) (gcc version 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #6 SMP Mon Jul 25 13:50:58 CEST 2005
> 
> If you reproduce with an unpatched kernel and an unpatched compiler, you are
> much more likely to get attention. Your problem might also just go away.

Or at least send this to the Gentoo folks, especially if the problem
goes away.

-- Steve


