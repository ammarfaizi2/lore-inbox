Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWEPSc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWEPSc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWEPSc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:32:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932501AbWEPScz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:32:55 -0400
Date: Tue, 16 May 2006 11:35:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       dzickus@redhat.com
Subject: Re: [PATCH] Kdump i386 nmi event notification fix
Message-Id: <20060516113518.6e63ed6b.akpm@osdl.org>
In-Reply-To: <20060516181559.GA16113@muc.de>
References: <20060515174835.GA28981@in.ibm.com>
	<20060516181559.GA16113@muc.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Mon, May 15, 2006 at 01:48:35PM -0400, Vivek Goyal wrote:
> > 
> > 
> > o After a crash we should wait for NMI IPI event and not for external NMI
> >   or NMI watchdog tick.
> 
> The two patches don't apply anymore after Don's big NMI rework.
> Can you forward port and retest/resend please?  

I have all this stuff queued up against your tree - I'll send it over.

