Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVHCJDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVHCJDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVHCJDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:03:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:13956 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262157AbVHCJDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:03:45 -0400
Date: Wed, 3 Aug 2005 11:03:44 +0200
From: Andi Kleen <ak@suse.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the debug.exception-trace sysctl by default
Message-ID: <20050803090344.GI10895@wotan.suse.de>
References: <1122533610.14066.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122533610.14066.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 11:53:30PM -0700, Nicholas Miell wrote:
> debug.exception-trace causes a large amount of log spew when on, and
> it's on by default, which is an irritation.

> Here's a patch to turn it off.
Rejected. 

-Andi
