Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUCaXei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 18:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbUCaXei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 18:34:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:12679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262129AbUCaXeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 18:34:36 -0500
Date: Wed, 31 Mar 2004 14:49:34 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Greg KH <gregkh@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RPA PCI Hotplug - redundant free
Message-ID: <20040331224934.GA5490@kroah.com>
References: <1080765544.1889.13.camel@verve.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080765544.1889.13.camel@verve.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 02:39:04PM -0600, John Rose wrote:
> Hi Greg-
> 
> Apologies for the resend, messed up the lkml address.  Please commit the
> following patch, which removes a redundant call to a
> cleanup function from an error path of the module init code.

Applied, thanks.

greg k-h
