Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVAFRmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVAFRmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVAFRjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:39:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:47803 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262939AbVAFRhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:37:48 -0500
Subject: Re: 2.6.10 kernel panic: IDE/SCSI related?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jago25_98 <jago25_98@bluebottle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104960539.41dc5c1b93c17@bluebottle.com>
References: <1104960539.41dc5c1b93c17@bluebottle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105023812.24187.215.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 16:30:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 21:28, jago25_98 wrote:
> I'm getting regular kernel panics with a vanilla 2.6.10 kernel.
> 
> Not sure how to tell which bit is causing the panic from the output
> (which isn't logged).

Make sure you've applied the fixes for the nasties in 2.6.10 as shipped
- notably if you said Y or M to ACPI video support you must apply the
patches posted later.


