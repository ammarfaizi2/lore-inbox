Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266408AbUAVTpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266413AbUAVTpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:45:54 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:52897 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266408AbUAVTpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:45:25 -0500
Date: Thu, 22 Jan 2004 19:44:04 +0000
From: Dave Jones <davej@redhat.com>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 agpgart and acpi standby/resume
Message-ID: <20040122194404.GA9807@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Terence Ripperda <tripperda@nvidia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040122185807.GD506@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122185807.GD506@hygelac>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 12:58:07PM -0600, Terence Ripperda wrote:

 > I'm curious why support was only added for 2 cases, instead of reconfiguring
 > the chipset in every case. Is this because there were problems with some
 > drivers, or is support added only on an "as-needed" basis?

The latter, though more an "as-tested" basis.

		Dave

