Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVD1EQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVD1EQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 00:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVD1EQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 00:16:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:47013 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261903AbVD1EQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 00:16:46 -0400
Date: Wed, 27 Apr 2005 21:16:24 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11 of 12] Fix Tpm driver -- add cancel function
Message-ID: <20050428041624.GC9723@kroah.com>
References: <Pine.LNX.4.61.0504271654260.3929@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504271654260.3929@jo.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 05:19:17PM -0500, Kylene Hall wrote:
> Userspcace needs to be able to cancel functions which have been sent to 
> the TPM (part of the spec.).  Add a sysfs file that communicates this 
> desire to the driver and device.

Huh?  I don't see any "add a sysfs file" code in this patch.  Am I
missing something?

thanks,

greg k-h
