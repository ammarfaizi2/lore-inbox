Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVBKJxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVBKJxp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 04:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVBKJxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 04:53:45 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:14603 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262229AbVBKJwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 04:52:38 -0500
Date: Fri, 11 Feb 2005 10:52:37 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211095237.GA53532@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg KH <gregkh@suse.de>, linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050211004033.GA26624@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211004033.GA26624@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 04:40:33PM -0800, Greg KH wrote:
> 	- autoload programs for usb, scsi, and pci modules.  These
> 	  programs determine what module needs to be loaded when the
> 	  kernel emits a hotplug event for these types of devices.  This
> 	  works just like the existing linux-hotplug scripts, with a few
> 	  exceptions.

firmware?

  OG.
