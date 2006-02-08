Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWBHSgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWBHSgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWBHSgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:36:51 -0500
Received: from [81.2.110.250] ([81.2.110.250]:16017 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030438AbWBHSgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:36:50 -0500
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060208174224.GD14105@suse.de>
References: <20060208062007.GA7936@kroah.com>
	 <1139408629.26270.38.camel@localhost.localdomain>
	 <20060208174224.GD14105@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Feb 2006 18:38:43 +0000
Message-Id: <1139423923.27721.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-08 at 09:42 -0800, Greg KH wrote:
> > For a good reason. When Linus first accepted the _GPL changes he did so
> > on the clear understanding that people wouldn't go around "privatising" 
> > existing symbols.
> 
> But look at Documentation/feature-removal-schedule.txt:

RCIU is special. Very special in that it uses patented techniques that
are only avaialble to GPL users without signing licenses with IBM.

The rest of the problem I concur with. I'm simply explaining the
historical background.

