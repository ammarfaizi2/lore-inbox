Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291640AbSCIHZG>; Sat, 9 Mar 2002 02:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291333AbSCIHYh>; Sat, 9 Mar 2002 02:24:37 -0500
Received: from ns.caldera.de ([212.34.180.1]:1253 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S291640AbSCIHXH>;
	Sat, 9 Mar 2002 02:23:07 -0500
Date: Sat, 9 Mar 2002 08:22:58 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Dave Jones <davej@suse.de>, Patricia Gaughen <gone@us.ibm.com>,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Message-ID: <20020309082258.A24374@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Dave Jones <davej@suse.de>, Patricia Gaughen <gone@us.ibm.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com> <20020308223330.A15106@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020308223330.A15106@suse.de>; from davej@suse.de on Fri, Mar 08, 2002 at 10:33:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 10:33:30PM +0100, Dave Jones wrote:
>   arch/i386/generic/

I'd rather call it pc, x86at or something like that.
Just because 99% of the i386 machines are IBM's PC AT architecture it's
still not generic :)

