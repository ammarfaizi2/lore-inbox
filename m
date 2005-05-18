Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVERJlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVERJlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVERJlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:41:10 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:52174 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262142AbVERJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:41:05 -0400
Subject: Re: PROBLEM: computer freezes / harddisk led stays on after S3
	resume
From: Erik Slagter <erik@slagter.name>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1DYL0O-0006Cf-00@chiark.greenend.org.uk>
References: <1116408408.3505.26.camel@localhost.localdomain>
	 <E1DYL0O-0006Cf-00@chiark.greenend.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 May 2005 11:40:44 +0200
Message-Id: <1116409244.3505.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 10:38 +0100, Matthew Garrett wrote:
> Erik Slagter <erik@slagter.name> wrote:
> > 1. computer freezes / harddisk led stays on after S3 resume
> 
> Linux doesn't currently implement the IDE resume part of the ACPI spec,
> which probably has something to do with this.

Any plans?

It seems at least some people have working S3, so?
