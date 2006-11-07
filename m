Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753140AbWKGU34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbWKGU34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbWKGU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:29:56 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:26068 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1753140AbWKGU3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:29:55 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Linux 2.6.16.31
Date: Tue, 7 Nov 2006 21:28:09 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
References: <20061107141349.GA4729@stusta.de>
In-Reply-To: <20061107141349.GA4729@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611072128.10331.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tuesday, 7. November 2006 15:13, Adrian Bunk wrote:
> Security fixes since 2.6.16.30:
> - CVE-2006-4572: fix ip6_tables bypass bugs
> - CVE-2006-5174: s390: fix user readable uninitialised kernel memory
> - CVE-2006-5619: IPV6: fix lockup via /proc/net/ip6_flowlabel

[...]

> Changes since 2.6.16.30:

[...]

Wow! That's an good announcement. I wish that would be standard format
for stable kernel release announcements.


Regards

Ingo Oeser
