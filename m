Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUGUGXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUGUGXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 02:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUGUGXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 02:23:23 -0400
Received: from 209-87-233-98.storm.ca ([209.87.233.98]:33429 "EHLO
	ottawa.interneqc.com") by vger.kernel.org with ESMTP
	id S265510AbUGUGXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 02:23:22 -0400
Date: Wed, 21 Jul 2004 02:14:41 -0400
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] kref shrinkage patches -- 2 of 2 -- kref shrinkage
Message-ID: <20040721061441.GC18787@kroah.com>
References: <20040720122307.GA1235@obelix.in.ibm.com> <20040720122659.GB1235@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720122659.GB1235@obelix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 05:57:01PM +0530, Ravikiran G Thirumalai wrote:
> Here's the patch to change current kref users to use the modified 
> kref_init and kref_put api (result of kref object shrinkage).

I applied this too, with some tweaks to the usb-serial code.

thanks,

greg k-h
