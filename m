Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWGNCWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWGNCWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWGNCWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:22:22 -0400
Received: from jg555.com ([64.30.195.78]:30102 "EHLO jg555.com")
	by vger.kernel.org with ESMTP id S1161189AbWGNCWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:22:21 -0400
Message-ID: <44B6FEDE.4040505@jg555.com>
Date: Thu, 13 Jul 2006 19:18:06 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
References: <44B443D2.4070600@jg555.com> <1152836749.31372.36.camel@shinybook.infradead.org>
In-Reply-To: <1152836749.31372.36.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,
    There are several of them like that. I'll just list the files, and 
the issues

    asm-ia64/page.h - Config variables
    asm-sparc/page.h - Config variables
    asm-sparc64/page.h - Config variables
    asm-powerpc/page.h - Config variables

I'll go through the rest over the next few days.
