Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVEIS7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVEIS7R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVEIS7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:59:16 -0400
Received: from peabody.ximian.com ([130.57.169.10]:14051 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261497AbVEIS7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:59:09 -0400
Subject: Re: [patch] updated inotify.
From: Robert Love <rml@novell.com>
To: coywolf@lovecn.org
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <2cd57c9005050911561b9b987@mail.gmail.com>
References: <1115654707.6734.134.camel@betsy>
	 <2cd57c90050509104363efed0e@mail.gmail.com>
	 <1115661400.6734.149.camel@betsy>
	 <2cd57c9005050911561b9b987@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 09 May 2005 14:58:19 -0400
Message-Id: <1115665099.6734.154.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 02:56 +0800, Coywolf Qi Hunt wrote:

> This warning is fixed in the previous patch.  It''s not necessary for
> this update. Better change it back to keep the placeholder one and the
> real.one of the same declaration.

I thought so.  Thanks.

My patch is actually fine, except I did not update the other function.
Anyhow..

	Robert Love


