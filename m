Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRHTTgt>; Mon, 20 Aug 2001 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268923AbRHTTgj>; Mon, 20 Aug 2001 15:36:39 -0400
Received: from granite.he.net ([216.218.226.66]:784 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S268900AbRHTTgX>;
	Mon, 20 Aug 2001 15:36:23 -0400
Date: Mon, 20 Aug 2001 12:36:25 -0700
From: Greg KH <greg@kroah.com>
To: Pierre JUHEN <pierre.juhen@wanadoo.fr>
Cc: mj@suse.cz, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net
Subject: Re: PROBLEM : PCI hotplug crashes with 2.4.9
Message-ID: <20010820123625.A31374@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Pierre JUHEN <pierre.juhen@wanadoo.fr>, mj@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <3B816617.F5C1CD24@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B816617.F5C1CD24@wanadoo.fr>; from pierre.juhen@wanadoo.fr on Mon, Aug 20, 2001 at 09:33:43PM +0200
X-Operating-System: Linux 2.2.19 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 09:33:43PM +0200, Pierre JUHEN wrote:
> 
> [3.] PCI hotplug kernel

Do you mean a kernel with the PCI hotplug controller patch that is
at http://www.kroah.com/linux/hotplug/  ?

Or just the CONFIG_HOTPLUG selection enabled?

thanks,

greg k-h
