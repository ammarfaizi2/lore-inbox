Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWDCRx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWDCRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWDCRx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:53:28 -0400
Received: from ns.suse.de ([195.135.220.2]:21175 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964822AbWDCRx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:53:27 -0400
From: Andi Kleen <ak@suse.de>
To: john.blackwood@ccur.com
Subject: Re: [PATCH] arch/x86_64/kernel/process.c do_arch_prctl() ARCH_GET_GS
Date: Mon, 3 Apr 2006 12:52:51 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <443135C9.7070008@ccur.com>
In-Reply-To: <443135C9.7070008@ccur.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604031252.51867.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 16:48, John Blackwood wrote:

> Maybe one of these approaches could be used as a fix.

Thank you. I applied approach #1

-Andi
