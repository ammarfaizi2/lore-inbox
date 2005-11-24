Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030594AbVKXEBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030594AbVKXEBh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbVKXEBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:01:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37533 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030594AbVKXEBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:01:36 -0500
Date: Wed, 23 Nov 2005 23:00:49 -0500
From: Dave Jones <davej@redhat.com>
To: gcoady@gmail.com
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       david.fox@linspire.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2 pci_ids.h cleanup is a pain
Message-ID: <20051124040049.GA30849@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, gcoady@gmail.com,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	david.fox@linspire.com, linux-kernel@vger.kernel.org
References: <438249CB.8050200@linspire.com> <20051121224438.GA18966@kroah.com> <20051122162558.702fae4a.akpm@osdl.org> <41i7o11nbvrfrd8n2ev6kf11qjfjbil3jr@4ax.com> <20051123041917.GA27358@redhat.com> <ppn9o111e7dbghgjn4luruvggke8r3k8u7@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ppn9o111e7dbghgjn4luruvggke8r3k8u7@4ax.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 08:41:12AM +1100, Grant Coady wrote:

 > >Three. I already mentioned we broke the compilation of the
 > >advansys driver because of this.
 > 
 > Nope, advansys.* don't appear to use PCI_*  Defines its own ASC_PCI* 
 > instead?

I stand corrected.

		Dave
