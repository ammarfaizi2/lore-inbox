Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVDFPre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVDFPre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVDFPre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:47:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:10627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262234AbVDFPr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:47:29 -0400
Date: Wed, 6 Apr 2005 08:46:49 -0700
From: Greg KH <gregkh@suse.de>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Renate Meijer <kleuske@xs4all.nl>, jdike@karaya.com,
       Blaisorblade <blaisorblade@yahoo.it>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: [08/08] uml: va_copy fix
Message-ID: <20050406154648.GA28638@kroah.com>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <20050406113233.GD7031@wohnheim.fh-wedel.de> <14410feafdb3a83e1ae457b93e593b81@xs4all.nl> <20050406122750.GE7031@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050406122750.GE7031@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 02:27:51PM +0200, J?rn Engel wrote:
> 
> Is it worth the effort?  Not sure.  But the "it's old, drop support
> for it" argument just doesn't cut it and it doesn't get any better by
> repetition.

Exactly, that's why this patch is valid.

thanks,

greg k-h
