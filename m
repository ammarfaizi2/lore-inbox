Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUFUMcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUFUMcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 08:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUFUMcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 08:32:16 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:14211 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S266179AbUFUMcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 08:32:14 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: sata promise problems on x86_64
Date: Mon, 21 Jun 2004 13:29:32 +0100
User-Agent: KMail/1.6
Cc: Miroslav Ruda <ruda@ics.muni.cz>, marcelo.tosatti@cyclades.com,
       jgarzik@pobox.com
References: <40D6C80B.2020202@ics.muni.cz>
In-Reply-To: <40D6C80B.2020202@ics.muni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406211329.32085.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 Jun 2004 12:35, Miroslav Ruda wrote:
>
>  I have problems with SATA promise driver from  2.4.27-rc1 on x86_64 arch
> (MB ASUS SK8V). Kernel 2.4.27-rc1 reports

I've been having similar problems with an SK8N, but with 2.6.7 kernel. It's 
ACPI related, and I suspect also effects 2.4. I guess you have ACPI enabled?

We've been working the problem here

	http://bugme.osdl.org/show_bug.cgi?id=2838

I'm just working through Lens last couple of postings now.

Andrew Walrond
