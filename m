Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUHEOmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUHEOmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267690AbUHEOmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:42:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60556 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267685AbUHEOL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:11:27 -0400
Date: Thu, 5 Aug 2004 10:11:14 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Michal Ludvig <mludvig@suse.cz>
cc: linux-kernel@vger.kernel.org, <cryptoapi@lists.logix.cz>
Subject: Re: [PATCH]
In-Reply-To: <41123B7E.2060601@suse.cz>
Message-ID: <Xine.LNX.4.44.0408051000130.17694-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Michal Ludvig wrote:

> Hi James,
> 
> the aes-i586 patch recently added to BK breaks compilation of AES on
> non-i586 platforms. Attached patch fixes it.

Thanks, the code is about to be dropped and replaced, so we need to
remember to fix it then.


- James
-- 
James Morris
<jmorris@redhat.com>


