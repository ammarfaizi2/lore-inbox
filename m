Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVKQX7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVKQX7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVKQX7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:59:49 -0500
Received: from mail.kroah.org ([69.55.234.183]:60345 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965143AbVKQX7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:59:48 -0500
Date: Thu, 17 Nov 2005 15:44:06 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] PCI Error Recovery: header file patch
Message-ID: <20051117234406.GA10573@kroah.com>
References: <20051108234911.GC19593@austin.ibm.com> <20051108235357.GD19593@austin.ibm.com> <20051116231041.GA16057@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116231041.GA16057@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 05:10:41PM -0600, linas wrote:
> 
> Greg, Please apply. This has been modified to use unsigned int's
> per disucssion.

Ok, I've added this one now, and dropped the previous two I had.  Can
you bounce me the other 6 patches in the series, I dropped them from my
inbox a while ago.

thanks,

greg k-h
