Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265184AbUELTb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265184AbUELTb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUELTbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:31:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37508 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265199AbUELTaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:30:05 -0400
Date: Wed, 12 May 2004 20:30:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: GCC nested functions?
Message-ID: <20040512193004.GG17014@parcelfarce.linux.theplanet.co.uk>
References: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 10:59:24AM -0700, Stephen Hemminger wrote:
> I used GCC nested functions in the (not released) bridge sysfs interface for 2.6.6.
> It seemed like a nice way to express the sysfs related interface without doing
> lots of code copying (or worse lots of macros).

If nested functions are answer, you've got the wrong question...
