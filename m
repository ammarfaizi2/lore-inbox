Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271344AbUJVPAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271344AbUJVPAl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271331AbUJVO5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:57:21 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.27]:41077 "EHLO
	mwinf0407.wanadoo.fr") by vger.kernel.org with ESMTP
	id S271329AbUJVO4v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:56:51 -0400
Subject: Re: Buggy DSDTs policy ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Onur Kucuk <onur@delipenguen.net>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041022174154.2ebd2c5c.onur@delipenguen.net>
References: <20041022122326.GA69381@dspnet.fr.eu.org>
	 <20041022174154.2ebd2c5c.onur@delipenguen.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <1098456935.31003.77.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 22 Oct 2004 16:55:35 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 22/10/2004 à 16:41, Onur Kucuk a écrit :
> On Fri, 22 Oct 2004 14:23:27 +0200
> Olivier Galibert <galibert@pobox.com> wrote:
> 
> > What is the policy w.r.t broken DSDTs and the ACPI subsystem?
> > Specifically, which of these two options is right:
> > 
> > 1- Provide a non-buggy DSDT to the kernel
> > 2- Make the ACPI subsystem tolerant of the bugs
> > 
> > The option 3, have all biosen over the world fixed is a nice fantasy,
> > but nothing else.
> > 
> > If 1, we need to put a mechanism for that in the official kernel.
> 
>  CONFIG_ACPI_CUSTOM_DSDT is included in 2.6.9

But fixed DSDTs are a pain to find, and fixing a buggy DSDT is
impossible for a non-hacker.

	Xav

