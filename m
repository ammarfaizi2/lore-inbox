Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUANPWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUANPWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:22:15 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:58752 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261262AbUANPWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:22:14 -0500
Date: Wed, 14 Jan 2004 15:21:53 +0000
From: Dave Jones <davej@redhat.com>
To: paul.devriendt@amd.com, pavel@ucw.cz, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114152152.GB5496@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com,
	pavel@ucw.cz, cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com> <20040113230605.GM14674@redhat.com> <20040114101041.GB16737@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114101041.GB16737@dominikbrodowski.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:10:41AM +0100, Dominik Brodowski wrote:
 > On Tue, Jan 13, 2004 at 11:06:05PM +0000, Dave Jones wrote:
 > > Part of the justification for cpufreq (at least on x86) was an alternative
 > > for when ACPI just doesn't work, or for when folks either don't want to,
 > > or can't run ACPI (through various other AML bugs for eg).
 > 
 > Except that the ACPI P-States implementation also uses the cpufreq
 > infrastructure.

Sure, but that came later.. 

		Dave

