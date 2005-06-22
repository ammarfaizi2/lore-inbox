Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVFVQLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVFVQLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVFVQLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:11:07 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:51979 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261570AbVFVQIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:08:40 -0400
Date: Wed, 22 Jun 2005 11:14:52 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: UML problems / kernel panic
Message-ID: <20050622151452.GA7404@ccure.user-mode-linux.org>
References: <20050622132520.GA4440@ccure.user-mode-linux.org> <20050622144301.GB7074@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622144301.GB7074@schottelius.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 04:43:01PM +0200, Nico Schottelius wrote:
> Do you mean 2.6.12?

This is the fix:

http://groups-beta.google.com/group/linux.kernel/browse_thread/thread/377cd92692a1e241/7985846c17410e06?q=%22jeff+dike%22&rnum=50&hl=en#7985846c17410e06

>From the filenames in the patch, I was working against rc3 at the time,
so it probably went into mainline around rc4 or so.

				Jeff
