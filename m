Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVALSVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVALSVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVALSVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:21:50 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:33712 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261265AbVALSUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:20:07 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: page table lock patch V15 [0/7]: overview
Date: Wed, 12 Jan 2005 18:20:02 +0000
User-Agent: KMail/1.7.2
References: <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com> <20050112174101.GA5838@infradead.org> <Pine.LNX.4.58.0501120951140.10806@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0501120951140.10806@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121820.02337.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 January 2005 17:52, Christoph Lameter wrote:
> On Wed, 12 Jan 2005, Christoph Hellwig wrote:
> > These smaller systems are more likely x86/x86_64 machines ;-)
>
> But they will not have been build in 1998 either like the machine I used
> for the i386 tests. Could you do some tests on contemporary x86/x86_64
> SMP systems with large memory?

I have various dual x86_64 systems with 1-4Gb ram. What tests do you want run?

Andrew Walrond
