Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267155AbSLDWxV>; Wed, 4 Dec 2002 17:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbSLDWxU>; Wed, 4 Dec 2002 17:53:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44813 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267155AbSLDWxU>;
	Wed, 4 Dec 2002 17:53:20 -0500
Date: Wed, 4 Dec 2002 15:00:50 -0800
From: Greg KH <greg@kroah.com>
To: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions - take 2
Message-ID: <20021204230050.GB29519@kroah.com>
References: <20021201083056.GJ679@kroah.com> <20021204001322.GA23464@kroah.com> <20021204001438.B25613@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204001438.B25613@figure1.int.wirex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 12:14:38AM -0800, Chris Wright wrote:
> 
> Also, I think the fixup should go directly in verify, since they are
> always called together.  Otherwise, this looks good.  Thanks, it's been
> sorely needed.

Thanks for the changes, I'll use your version of this :)

greg k-h
