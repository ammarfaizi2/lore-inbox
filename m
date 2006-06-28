Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWF1UNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWF1UNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWF1UNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:13:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751190AbWF1UNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:13:54 -0400
Date: Wed, 28 Jun 2006 16:13:48 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Move export symbols to their C functions
Message-ID: <20060628201348.GI23396@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200606261902.k5QJ2R93008443@hera.kernel.org> <20060628193841.GA22587@redhat.com> <200606282152.20698.ak@suse.de> <20060628195632.GH23396@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628195632.GH23396@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 03:56:32PM -0400, Dave Jones wrote:
 > On Wed, Jun 28, 2006 at 09:52:20PM +0200, Andi Kleen wrote:
 >  > 
 >  > > These two exports were never re-added, which broke modular oprofile.
 >  > 
 >  > Everybody and their dog sent patches for that by now and I assume
 >  > Linus already merged Andrew's version
 > 
 > Ah, didn't see them, and my tree seems to be stale.
 > Yes, looks fixed.

Actually, I take that back, I was looking at the wrong tree (again).
It's not fixed in Linus tree yet in a git pull from a few minutes ago.

Anyone else notice that head-commits is also really slow ?
Lately I get commit mails from 12-24hrs earlier from it.

		Dave

-- 
http://www.codemonkey.org.uk
