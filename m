Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281641AbRKUWIM>; Wed, 21 Nov 2001 17:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281683AbRKUWIC>; Wed, 21 Nov 2001 17:08:02 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:57861 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281641AbRKUWHu>;
	Wed, 21 Nov 2001 17:07:50 -0500
Date: Wed, 21 Nov 2001 15:05:15 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: visor.o oopses in 2.4.14
Message-ID: <20011121150515.A11113@kroah.com>
In-Reply-To: <20011121005419.A11766@gintaras>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011121005419.A11766@gintaras>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 24 Oct 2001 22:01:23 -0700
X-Message-Flag: Message text blocked: Unsuitable for Adults
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 12:54:19AM +0200, Marius Gedminas wrote:
> Syncing my Palm m500 with coldsync 2.2.0 always results in an oops.  This
> happened on 2.4.12 and 2.4.14

Can you try 2.4.15-pre8?  There should be a patch in there that fixes
this problem.

thanks,

greg k-h
