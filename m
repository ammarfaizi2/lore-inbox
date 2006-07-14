Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161294AbWGNTcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161294AbWGNTcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161296AbWGNTcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:32:52 -0400
Received: from jg555.com ([64.30.195.78]:5532 "EHLO jg555.com")
	by vger.kernel.org with ESMTP id S1161294AbWGNTcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:32:52 -0400
Message-ID: <44B7F062.8040102@jg555.com>
Date: Fri, 14 Jul 2006 12:28:34 -0700
From: Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
References: <44B443D2.4070600@jg555.com>	 <1152836749.31372.36.camel@shinybook.infradead.org>	 <44B6FEDE.4040505@jg555.com> <1152903332.3191.87.camel@pmac.infradead.org>
In-Reply-To: <1152903332.3191.87.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, a lot programs out there are using page.h, and a lot of 
people are using that in their programs. The 2 program I know for sure 
that use page.h are glibc and util-linux.

