Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270682AbTGPMIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270702AbTGPMIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:08:44 -0400
Received: from holomorphy.com ([66.224.33.161]:4577 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270682AbTGPMIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:08:42 -0400
Date: Wed, 16 Jul 2003 05:24:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716122454.GJ15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, "Barry K. Nathan" <barryn@pobox.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030715225608.0d3bff77.akpm@osdl.org> <20030716104448.GC25869@ip68-4-255-84.oc.oc.cox.net> <20030716035848.560674ac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716035848.560674ac.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Barry K. Nathan" <barryn@pobox.com> wrote:
>>  arch/ppc/kernel/irq.c: At top level:  
>>  arch/ppc/kernel/irq.c:575: braced-group within expression allowed only
>>  inside a function

On Wed, Jul 16, 2003 at 03:58:48AM -0700, Andrew Morton wrote:
> Bill?

Building a cross-compiler and taking a stab at fixing it...


-- wli
