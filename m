Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269001AbRHCMxL>; Fri, 3 Aug 2001 08:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269002AbRHCMxB>; Fri, 3 Aug 2001 08:53:01 -0400
Received: from mail.intrex.net ([209.42.192.246]:4371 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S269001AbRHCMwu>;
	Fri, 3 Aug 2001 08:52:50 -0400
Date: Fri, 3 Aug 2001 08:53:06 -0400
From: jlnance@intrex.net
To: Nikita Danilov <NikitaDanilov@Yahoo.COM>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH]: reiserfs: D-clear-i_blocks.patch
Message-ID: <20010803085306.A1248@bessie.localdomain>
In-Reply-To: <15209.30134.699801.417492@beta.namesys.com> <200108021726.f72HQrMh027270@webber.adilger.int> <15209.40051.124575.787738@beta.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15209.40051.124575.787738@beta.namesys.com>; from NikitaDanilov@Yahoo.COM on Thu, Aug 02, 2001 at 10:31:15PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 10:31:15PM +0400, Nikita Danilov wrote:
> Andreas Dilger writes:
>  > PS - could someone on the reiserfs team (or Linus) run the reiserfs code
>  >      through "indent" (or auto format in emacs) per
>  >      Documentation/CodingStyle?  It is really a gross mess, to such a
>  >      point that you can hardly see what
> 
> Oh, yes.
> 
>  >      is going on.  It's not just that it is a different indent style, it
>  >      has no coherent indentation or comment formatting at all.  Maybe
>  >      for 2.5?
> 
> I hope so. We already have 200k of cleanup patches in 2.4.7-ac3.

>From past experience, if you want to run the code through indent, I would
recomend that you submit patches for that which contain no other changes.
If you mix indent changes with code changes, it gets very difficult to
see what was actually changed if bugs crop up.

Thanks,

Jim
