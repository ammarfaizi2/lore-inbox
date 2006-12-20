Return-Path: <linux-kernel-owner+w=401wt.eu-S964778AbWLTCPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWLTCPm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 21:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWLTCPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 21:15:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54816 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964778AbWLTCPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 21:15:41 -0500
Date: Tue, 19 Dec 2006 18:15:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: Changes to sysfs PM layer break userspace
Message-Id: <20061219181524.c15c02af.akpm@osdl.org>
In-Reply-To: <200612191334.49760.david-b@pacbell.net>
References: <20061219185223.GA13256@srcf.ucam.org>
	<1166559785.3365.1276.camel@laptopd505.fenrus.org>
	<20061219203251.GA14648@srcf.ucam.org>
	<200612191334.49760.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 13:34:49 -0800
David Brownell <david-b@pacbell.net> wrote:

> Documentation/feature-removal-schedule.txt has warned about this since
> August

Nobody reads that.

Please, wherever possible, put a nice printk("this is going away") in the code
when planning these things.
