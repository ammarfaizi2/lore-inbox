Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbUANDfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 22:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUANDfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 22:35:10 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:46294 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265965AbUANDfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 22:35:07 -0500
Date: Wed, 14 Jan 2004 03:33:26 +0000
From: Dave Jones <davej@redhat.com>
To: paul.devriendt@amd.com
Cc: pavel@ucw.cz, cpufreq@www.linux.org.uk, linux@brodo.de,
       linux-kernel@vger.kernel.org, mark.langsdorf@amd.com
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114033326.GR14674@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com,
	pavel@ucw.cz, cpufreq@www.linux.org.uk, linux@brodo.de,
	linux-kernel@vger.kernel.org, mark.langsdorf@amd.com
References: <99F2150714F93F448942F9A9F112634C080EF398@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF398@txexmtae.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 08:49:28PM -0600, paul.devriendt@amd.com wrote:

 > Dave had a good idea of a minimal ACPI parser for trying to retrieve the
 > table of p-states from an ACPI BIOS without needing the full AML interpreter.
 > I will see if I can get that to work in powernow-k8-acpi 
 
If done properly, that parsing code could be shared by the K7 driver too.

		Dave

