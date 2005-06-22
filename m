Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVFVKGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVFVKGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVFVKFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:05:35 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:63413 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262746AbVFVKFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:05:07 -0400
Date: Wed, 22 Jun 2005 14:04:48 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
Message-ID: <20050622140448.A32312@jurassic.park.msu.ru>
References: <20050619233029.45dd66b8.akpm@osdl.org> <20050620131451.GA9739@shadowen.org> <20050621225551.GB24289@suse.de> <42B92DFA.7060705@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <42B92DFA.7060705@shadowen.org>; from apw@shadowen.org on Wed, Jun 22, 2005 at 10:23:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 10:23:06AM +0100, Andy Whitcroft wrote:
> Ivan, can you shead any light on whether the hunk of your patch above is
> one of the three fixes, whether its a fourth fix, and indeed whether its
> needed?

This is the core part of those four changes (and actually it should have
been attributed to Linus).
So your patch is absolutely correct, thanks.

Ivan.
