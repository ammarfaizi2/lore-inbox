Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUGBPvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUGBPvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 11:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUGBPvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 11:51:11 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:34178 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S264251AbUGBPvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 11:51:09 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: MSI to memory?
Date: Fri, 2 Jul 2004 09:51:08 -0600
User-Agent: KMail/1.6.2
Cc: Tom L Nguyen <tom.l.nguyen@intel.com>, linux-kernel@vger.kernel.org
References: <200407011215.59723.bjorn.helgaas@hp.com> <20040701115339.A4265@unix-os.sc.intel.com>
In-Reply-To: <20040701115339.A4265@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407020951.08038.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 July 2004 12:53 pm, Rajesh Shah wrote:
> On Thu, Jul 01, 2004 at 12:15:59PM -0600, Bjorn Helgaas wrote:
> > If so, is that a useful capability that should be exposed through
> > the Linux MSI interface?
> ...
> What type of usage model did you have in mind to have the 
> device write to memory instead of using MSI for interrupts?

I'm not a driver writer.  I don't have any usage model in mind.  I'm
merely asking whether this is interesting functionality, because I
don't see any generic way to use it, given the current Linux MSI
interfaces.  I guess the answer is "the time to figure out an interface
is when somebody figures out an interesting way to use it."
