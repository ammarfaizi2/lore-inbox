Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVKLCAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVKLCAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVKLCAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:00:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbVKLCAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:00:33 -0500
Date: Fri, 11 Nov 2005 17:59:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org, ak@muc.de,
       zwane@arm.linux.org.uk, rusty@rustycorp.com.au, vatsa@in.ibm.com,
       jschopp@austin.ibm.com, anil.s.keshavamurthy@intel.com
Subject: Re: Documentation for CPU hotplug support
Message-Id: <20051111175953.7a5ce8dd.akpm@osdl.org>
In-Reply-To: <20051111072300.GY8977@localhost.localdomain>
References: <20051110075932.A16271@unix-os.sc.intel.com>
	<20051111072300.GY8977@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch <nathanl@austin.ibm.com> wrote:
>
>  Argh, no.  That current_in_cpuhotplug hack has to go.

Yes, Ashok is busily working on removing that ;)

We shouldn't enshrine it in documentation.  Please.
