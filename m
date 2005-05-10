Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVEJAeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVEJAeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 20:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEJAep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 20:34:45 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:19587 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261459AbVEJAeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 20:34:44 -0400
Date: Mon, 9 May 2005 17:34:50 -0700
From: Greg KH <gregkh@suse.de>
To: ?ric BURGHARD <eric.burghard@systheo.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: quirks.c patch for Asus W1N laptop model support (asus_hides_smbus)
Message-ID: <20050510003449.GB25241@suse.de>
References: <200505080001.15329.eric.burghard@systheo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505080001.15329.eric.burghard@systheo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 12:01:15AM +0200, ?ric BURGHARD wrote:
> Hi,
> 
> Here's a patch for W1N notebook.

Hm, your email client ate the tabs in the patch, and it can't be applied
:(

Can you regenerate this, and add a Signed-off-by: line as per
Documentation/SubmittingPatches, and base the patch off of the main
kernel directory, and resend it with the same sentance above for a
description so I can apply it to the trees?

thanks,

greg k-h
