Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWASOIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWASOIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbWASOIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:08:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3475 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161200AbWASOIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:08:48 -0500
Subject: Re: io performance...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43CF90C6.8050505@fastmail.co.uk>
References: <5vx8f-1Al-21@gated-at.bofh.it> <5wbRY-3cF-3@gated-at.bofh.it>
	 <5wdKh-5wF-15@gated-at.bofh.it> <43CEF263.9060102@shaw.ca>
	 <43CF90C6.8050505@fastmail.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 14:08:18 +0000
Message-Id: <1137679698.8471.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 21:14 +0800, Max Waterman wrote:
> So, if I have my raid controller set to use write-back, it *is* caching 
> the writes, and so this *is* a bad thing, right?

Depends on your raid controller. If it is battery backed it may well all
be fine.

Alan
