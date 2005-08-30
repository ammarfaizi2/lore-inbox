Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVH3XvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVH3XvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVH3XvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:51:11 -0400
Received: from smtp.istop.com ([66.11.167.126]:65478 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751373AbVH3XvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:51:11 -0400
From: Daniel Phillips <phillips@istop.com>
To: viro@zeniv.linux.org.uk
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Date: Wed, 31 Aug 2005 09:51:06 +1000
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       linux-kernel@vger.kernel.org, greg@kroah.com
References: <200508310854.40482.phillips@istop.com> <20050830162846.5f6d0a53.akpm@osdl.org> <20050830233440.GA26264@ZenIV.linux.org.uk>
In-Reply-To: <20050830233440.GA26264@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508310951.07112.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 09:34, viro@ZenIV.linux.org.uk wrote:
> On Tue, Aug 30, 2005 at 04:28:46PM -0700, Andrew Morton wrote:
> > Sure, but all that copying-and-pasting really sucks.  I'm sure there's
> > some way of providing the slightly different semantics from the same
> > codebase?
>
> Careful - you've almost reinvented the concept of library, which would
> violate any number of patents...

I will keep my eyes open for library candidates as I go.  For example, the 
binary blob operations really cry out for it.

Regards,

Daniel
