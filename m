Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTJ2ODV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 09:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJ2ODV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 09:03:21 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:47328 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261321AbTJ2ODU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 09:03:20 -0500
Date: Wed, 29 Oct 2003 15:03:17 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ACPI && vortex still broken in latest 2.4 and 2.6.0-test9
Message-ID: <20031029140317.GF10693@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031029134848.GA949@hello-penguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029134848.GA949@hello-penguin.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Stefan Traby wrote:

> I just want to note that ACPI+3c59x is still not
> working on the latest kernels - the only solution
> is "acpi=off".

This "still broken" is too unspecific, 3c59x + ACPI works for me, in a
Gigabyte 7ZX-R (VIA KT133 based) mainboard, with SuSE 8.2 distro kernel
(ACPI 20030228), 2.4.22-pac1+acpi patches, and with latest 2.6.0-test9
BK.

I have two 3C905 and one 3C900Combo in a production router, everything
is the old "Boomerang" chip version. Rest assured I WOULD know if these
lost IRQs or were otherwise misconfigured.

> Affected are at least
> IBM Thinkpad T21  http://lkml.org/lkml/2003/6/15/111
> IBM Thinkpad A21p (3c556B Laptop Hurricane)

Might the problems you observe be related to the IBM BIOS?
