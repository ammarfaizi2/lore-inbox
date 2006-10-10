Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWJJPlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWJJPlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWJJPlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:41:52 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:41870 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750786AbWJJPlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:41:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAPpaK0WMEgIN
X-IronPort-AV: i="4.09,291,1157320800"; 
   d="scan'208"; a="4089007:sNHT32538584"
Date: Tue, 10 Oct 2006 17:41:48 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/02 V2] net/ipv6: seperate sit driver to extra module
Message-ID: <20061010154148.GC27455@zlug.org>
References: <20061009093416.GA11901@zlug.org> <20061009.213856.28787525.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009.213856.28787525.davem@davemloft.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:38:56PM -0700, David Miller wrote:
> Joerg, when you make resubmissions, please always restate the full
> changelog and all signed-off-by lines.
> 
> If you want to say "Changed since last version" do that seperately
> at the top of the email, right before the main changelog entry and
> the patch itself.
> 
> I wanted to apply this latest version of these two patches, but I
> cannot because the full changelog isn't here.  Please get this
> into a mergable form for me.

Ok, thanks for your hints. I resubmitted the changes with the
appropriate changelog entries. I should be ok now.
