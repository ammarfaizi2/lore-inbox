Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUHESDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUHESDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHESDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:03:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10653 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267858AbUHESCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:02:03 -0400
Date: Thu, 5 Aug 2004 14:02:00 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Program-invoking Symbolic Links?
In-Reply-To: <200408051504.26203.jmc@xisl.com>
Message-ID: <Pine.LNX.4.44.0408051401240.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, John M Collins wrote:

> latest_version.tar => "tar cf - /latest/and/greatest"
> latest_version.tgz => "gzip -c latest_version"

Next you know people will be asking for proper mmap semantics
on these.  I'd rather see this done in userland...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

