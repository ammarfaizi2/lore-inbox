Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVBOVBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVBOVBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVBOVAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:00:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:38788 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261892AbVBOU7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:59:00 -0500
Subject: Re: 2.6.9 IO-APIC + timer doesn't work! with VMWare 4
From: Lee Revell <rlrevell@joe-job.com>
To: Joseph Cosby <jocosby@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY102-F34629FB0CE60DB39785241AE6B0@phx.gbl>
References: <BAY102-F34629FB0CE60DB39785241AE6B0@phx.gbl>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 15:58:59 -0500
Message-Id: <1108501139.3772.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 13:29 -0700, Joseph Cosby wrote:
> Hi,
>   Using VMWare 4 with a 2.6.9 kernel I get "IO-APIC + timer doesn't work!" 
> As suggested, the noapic option fixes the problem. This resulted after 
> adding APIC support to my kernel. My problem is, I need APIC support to boot 
> on a separate, non-VMWare machine, and I need to keep the kernel and boot 
> params the same on both machines.
>   Aside from disabling APIC support, and running with the noapic parameter, 
> can anybody suggest how to get this running on the VMware machine?

Did you ask VMWare about it?

Lee

