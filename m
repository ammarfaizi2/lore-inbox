Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUCAMk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 07:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbUCAMk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 07:40:29 -0500
Received: from upco.es ([130.206.70.227]:44755 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261244AbUCAMk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 07:40:26 -0500
Date: Mon, 1 Mar 2004 13:40:24 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301124024.GA488@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20040228230039.GA246@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040228230039.GA246@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 12:00:40AM +0100, Pavel Machek wrote:
> Hi!
> 
> Would there be any major screaming if I tried to drop CONFIG_PM_DISK?
> It seems noone is maintaining it, equivalent functionality is provided
> by swsusp, and it is confusing users...
> 								Pavel

Last time I tried (2.6.1) PM_DISK was the only suspend mechanism that worked
on my vaio with ACPI enabled (PGC-FX701). I had not time (my humble
apologies to Nigel) to make more tests, I've been swamped with a conference
deadline, but I can try to help finding out the problem in the next weeks, I
hope. 

Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
