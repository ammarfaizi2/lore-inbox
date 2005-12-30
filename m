Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVL3BCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVL3BCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 20:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVL3BCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 20:02:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31878 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751185AbVL3BB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 20:01:59 -0500
Date: Thu, 29 Dec 2005 20:01:51 -0500
From: Dave Jones <davej@redhat.com>
To: Alejandro Bonilla <alejandro.bonilla@hp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: git fetching
Message-ID: <20051230010151.GC12822@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alejandro Bonilla <alejandro.bonilla@hp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43B48516.2030701@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B48516.2030701@hp.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 06:53:42PM -0600, Alejandro Bonilla wrote:
 > Why is it that when I git fetch, this particular part takes a long time?
 > 
 > pack/pack-2dae6bb81ac4383926b1d6a646e3f73b130ba124.pack
 > 
 > Normally, they go pretty fast, but when a new rc or final releases comes 
 > up, it takes a lot.

That file is ~100MB. That'll take a while to download compared to the rest,
even on the fastest net connection :)

		Dave

