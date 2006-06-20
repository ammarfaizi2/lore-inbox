Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWFTPav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWFTPav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWFTPav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:30:51 -0400
Received: from ns.suse.de ([195.135.220.2]:47784 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751319AbWFTPav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:30:51 -0400
From: Andi Kleen <ak@suse.de>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Re: [Bug 6451] CONFIG_KMOD is not set for x86_64 but is set to Y for i386 and other archs
Date: Tue, 20 Jun 2006 17:30:39 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606201433.k5KEXbhX003862@fire-2.osdl.org> <a06230977c0bdc14545ff@[129.98.90.227]>
In-Reply-To: <a06230977c0bdc14545ff@[129.98.90.227]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201730.39477.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 17:18, Maurice Volaski wrote:
> Hey, is this you? Why on Earth do you want this setting turned off?

Because I don't use it and arch/x86_64/defconfig is my configuration.
If you don't like it do your own.

-Andi

