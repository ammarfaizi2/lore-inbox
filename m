Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUJRQuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUJRQuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266878AbUJRQuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:50:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:2488 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266867AbUJRQuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:50:01 -0400
Subject: Re: [RFC][PATCH] inotify 0.14
From: Robert Love <rml@novell.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: John McCutchan <ttb@tentacle.dhs.org>, v13@priest.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
In-Reply-To: <20041018170016.71d271d1.sfr@canb.auug.org.au>
References: <1097808272.4009.0.camel@vertex>
	 <200410180246.27654.v13@priest.com> <1098057129.5497.107.camel@localhost>
	 <20041018112807.3a7edbf7.sfr@canb.auug.org.au>
	 <1098066043.16758.4.camel@vertex>
	 <20041018170016.71d271d1.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 18 Oct 2004 12:48:04 -0400
Message-Id: <1098118084.1597.0.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-18 at 17:00 +1000, Stephen Rothwell wrote:

> You should probably submit the patch making dnotify optional as a
> completely separate patch as it is logically s separate issue.

I agree.  I've submitted it before, I'll submit it again.

	Robert Love


