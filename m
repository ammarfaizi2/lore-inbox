Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVCNVlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVCNVlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVCNVki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:40:38 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:4669 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261928AbVCNVk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:40:26 -0500
Date: Mon, 14 Mar 2005 22:40:38 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] buildcheck: reduce DEBUG_INFO noise from reference* scripts
Message-ID: <20050314214038.GE17925@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>,
	akpm <akpm@osdl.org>
References: <29073.1110832439@ocs3.ocs.com.au> <42360443.8030606@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42360443.8030606@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 01:38:11PM -0800, Randy.Dunlap wrote:
 Indeed, it's actually much worse with that patch section added.  :(
> I don't know how I got there.
> 
> Sam, can you drop the very first patch section here, or shall I send
> a new patch for this?
Incremental patch please. I already have a few patches on top of this in
bitkeeper.

	Sam
