Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVI1NpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVI1NpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVI1NpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:45:07 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:58423 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750973AbVI1NpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:45:06 -0400
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand fixes for 2.6.14
X-Message-Flag: Warning: May contain useful information
References: <524q85on6e.fsf@cisco.com> <20050928093633.GA12757@kroah.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 28 Sep 2005 06:44:55 -0700
In-Reply-To: <20050928093633.GA12757@kroah.com> (Greg KH's message of "Wed,
 28 Sep 2005 02:36:33 -0700")
Message-ID: <52zmpxmhm0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Sep 2005 13:44:56.0736 (UTC) FILETIME=[D0058A00:01C5C432]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> I didn't think that git pulls were going to be allowed from
    Greg> subsystem maintainers after -rc1 came out.  After that,
    Greg> patches by email were required to be sent, not git pulls.
    Greg> This does cause a bit more work for the maintainer, but it
    Greg> ensures that they only send the patches they really want to
    Greg> get in.

I specifically asked Linus about this a couple of weeks ago, and he
said that bug-fix-only git merges are file.  See http://lkml.org/lkml/2005/9/13/277

 - R.
