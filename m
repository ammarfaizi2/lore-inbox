Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWF1T4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWF1T4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWF1T4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:56:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15839 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751143AbWF1T4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:56:39 -0400
Date: Wed, 28 Jun 2006 15:56:32 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Move export symbols to their C functions
Message-ID: <20060628195632.GH23396@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200606261902.k5QJ2R93008443@hera.kernel.org> <20060628193841.GA22587@redhat.com> <200606282152.20698.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606282152.20698.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 09:52:20PM +0200, Andi Kleen wrote:
 > 
 > > These two exports were never re-added, which broke modular oprofile.
 > 
 > Everybody and their dog sent patches for that by now and I assume
 > Linus already merged Andrew's version

Ah, didn't see them, and my tree seems to be stale.
Yes, looks fixed.

		Dave
-- 
http://www.codemonkey.org.uk
