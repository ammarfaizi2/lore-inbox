Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVKPR2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVKPR2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVKPR2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:28:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15277 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964994AbVKPR2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:28:11 -0500
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
From: David Woodhouse <dwmw2@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051115210459.GA11363@kroah.com>
References: <20051115210459.GA11363@kroah.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 17:28:09 +0000
Message-Id: <1132162089.21643.87.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 13:05 -0800, Greg KH wrote:
>  - "Programming the 80386" by Crawford and Gelsinger [Sybek]

Maybe, but on the whole I suspect we'd do well if fewer people were
thinking about one particular legacy architecture when writing kernel
code. 

Newbie kernel hackers ought to be working on something SMP, big-endian
and 64-bit. Get into good habits right away.

-- 
dwmw2

