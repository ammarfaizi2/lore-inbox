Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUCCTko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUCCTkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:40:43 -0500
Received: from [66.35.79.110] ([66.35.79.110]:52359 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262560AbUCCTkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:40:42 -0500
Date: Wed, 3 Mar 2004 11:40:34 -0800
From: Tim Hockin <thockin@hockin.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-hotplug-devel@vger.kernel.org, greg@kroach.com,
       linux-kernel@vger.kernel.org
Subject: Re: [QUESTION/PROPOSAL] udev (fwd)
Message-ID: <20040303194034.GA4681@hockin.org>
References: <Pine.LNX.4.58.0403032023090.1319@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403032023090.1319@alpha.polcom.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 08:27:17PM +0100, Grzegorz Kulewski wrote:
> So, (sorry if it was asked 100000000 times...

it has been

> ... but) why when kernel detects new device or module is loaded, no device 
> file in sysfs is created? The device files in /dev would be only links to 
> these in /sys. 

What mode should be applied to these files?  That alone is enough to make
one stop and reconsider the idea.
