Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268436AbUHYE7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268436AbUHYE7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268446AbUHYE7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:59:46 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:28070 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268436AbUHYE7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:59:45 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fix cc-version breakage
Date: Tue, 24 Aug 2004 21:59:21 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408241642.21886.jbarnes@engr.sgi.com> <200408241648.49261.jbarnes@engr.sgi.com> <20040825044351.GA7310@mars.ravnborg.org>
In-Reply-To: <20040825044351.GA7310@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408242159.21281.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2004 9:43 pm, Sam Ravnborg wrote:
> On Tue, Aug 24, 2004 at 04:48:49PM -0700, Jesse Barnes wrote:
> > Actually, this is a little nicer (look ma, no linewraps!) if we can make
> > gcc-version.sh executable.
>
> It is no possible for all users to guarantee this, therefore the rule of
> thumb for the kernel is to always use CONFIG_SHELL.
>
> Btw - patch already sent to Linus and lkml.

Ok, I thought the problem seemed familiar, and now I see the fix in the BK 
tree.  Thanks.

Jesse
