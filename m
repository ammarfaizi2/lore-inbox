Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTLWRJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 12:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTLWRJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 12:09:49 -0500
Received: from havoc.gtf.org ([63.247.75.124]:15564 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261837AbTLWRIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 12:08:30 -0500
Date: Tue, 23 Dec 2003 12:08:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: various issues with ACPI sleep and 2.6
Message-ID: <20031223170829.GA7726@gtf.org>
References: <20031223165739.GA28356@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223165739.GA28356@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 11:57:39AM -0500, Bill Nottingham wrote:
> Testing ACPI sleep under 2.6, I noticed the following issues
> (Thinkpad T40, i855PM chipset):

Do you have the latest BIOS?  There were some ACPI problems IBM
corrected (due to responses from Linux users!).


> - USB fails on resume (sent to linux-usb-devel)
> - DRI being loaded at all causes X to fail on resume

X power management is sorta "hope and pray" AFAIK :)

	Jeff


