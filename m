Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVKRNhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVKRNhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 08:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbVKRNhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 08:37:12 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:37986 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750724AbVKRNhK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 08:37:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HbrFFqg4iLCYZm8VbIkzCyPL80crsZViBIqc8r62mtMC6AdWEm7yqbKcz+E+HN5/YTpbFpsA7jyMLsr/UHr4YYknlbatLEWKpTJiJ/5eVIg+WkLK5TzXhYbwXCWuTp8X/NyCY/s8NoFd+2RAbVeQlFazY9Umh+lRj2U8cwpIvus=
Message-ID: <f990dfce0511180537i4becb5f1k611a58874e9bf972@mail.gmail.com>
Date: Fri, 18 Nov 2005 08:37:09 -0500
From: Brett Russ <bruss@alum.wpi.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <437D2DED.5030602@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114050404.GA18144@havoc.gtf.org>
	 <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>
	 <4379F31D.4000508@pobox.com>
	 <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>
	 <437D2DED.5030602@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> See if you can give the latest git tree a try (what will be
> 2.6.15-rc1-git6, later tonight).  I think I've killed most of the
> sata_mv bugs, and have it working here on both 50xx and 60xx.

Hey Jeff,

Been reading the patches you've been sending.  Thanks for picking it
up--there's no way I have time to work on it lately.  Glad to hear you
got it working on 50xx.  Some comments:

-in the future, can you separate whitespace only patch mailings with
functional patches?  I know that's something you request of others,
but it helps us too.

-the version # of sata_mv doesn't look like it was bumped.  Did I miss it?

thanks,
BR
