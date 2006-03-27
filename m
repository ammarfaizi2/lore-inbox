Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWC0IQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWC0IQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 03:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWC0IQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 03:16:49 -0500
Received: from mail.suse.de ([195.135.220.2]:52201 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750783AbWC0IQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 03:16:49 -0500
Message-ID: <44279FEC.2080305@suse.de>
Date: Mon, 27 Mar 2006 10:18:52 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Dan Hecht <dhecht@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063746.389133000@sorel.sous-sol.org> <4421D64F.6040907@vmware.com>
In-Reply-To: <4421D64F.6040907@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Rather than changing LOAD_OFFSET in Linux, why not leave this alone and
> change the Xen domain builder to properly interpret the ELF program
> header fields?

I've a patch in the queue which does exactly that ;)
Planned to submit just after xen 3.0.2 release ...

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
