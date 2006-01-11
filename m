Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWAKQBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWAKQBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 11:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWAKQA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 11:00:59 -0500
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:46829 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1751366AbWAKQA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 11:00:58 -0500
Date: Wed, 11 Jan 2006 10:00:50 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060111160050.GA5472@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C40803.2000106@rtr.ca>
X-Operating-System: Linux yggdrasil 2.6.15 #1 SMP PREEMPT Tue Jan 10 20:27:55 CST 2006 i686 GNU/Linux
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any benefit/point to enabling HIGHMEM when using this patch, 
assuming that physical memory is smaller than the address space?  For 
example, when using VMSPLIT_3G_OPT on a box with 1G of memory.

Thanx!
