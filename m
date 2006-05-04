Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWEDNUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWEDNUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWEDNUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:20:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:14528 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750711AbWEDNUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:20:32 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] fix unlikely profiling & vsyscalls on x86_64
Date: Thu, 4 May 2006 15:20:23 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, dwalker@mvista.com,
       linux-kernel@vger.kernel.org
References: <20060504131014.GA17036@elte.hu>
In-Reply-To: <20060504131014.GA17036@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605041520.23621.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 May 2006 15:10, Ingo Molnar wrote:
> fix unlikely profiling in vsyscalls ...

Applied thanks

-Andi
