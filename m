Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUCCWMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUCCWMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:12:06 -0500
Received: from [66.35.79.110] ([66.35.79.110]:34184 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261210AbUCCWLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:11:02 -0500
Date: Wed, 3 Mar 2004 14:10:53 -0800
From: Tim Hockin <thockin@hockin.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-hotplug-devel@vger.kernel.org, greg@kroach.com,
       linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/PROPOSAL] udev (fwd)
Message-ID: <20040303221053.GA11520@hockin.org>
References: <Pine.LNX.4.58.0403032023090.1319@alpha.polcom.net> <20040303194034.GA4681@hockin.org> <Pine.LNX.4.58.0403032150250.1319@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403032150250.1319@alpha.polcom.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 09:51:59PM +0100, Grzegorz Kulewski wrote:
> > What mode should be applied to these files?  That alone is enough to make
> > one stop and reconsider the idea.
> 
> For example 000 - no access for nobody, udev can change it if configured 
> to do so.

I don't know that sysfs has code to handle changing modes.  And in the end,
what does it buy you?
