Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTICUrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTICUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:47:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45064 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264242AbTICUrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:47:04 -0400
Date: Wed, 3 Sep 2003 22:37:53 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockups with 2.4.22 on a dual P3/Katmai
Message-ID: <20030903203753.GC24145@alpha.home.local>
References: <20030902193531.GA992@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902193531.GA992@digitasaru.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

wouldn't you have sort of a powersaving mode enabled in the bios or something
like that which could be triggered by recent changes ?

Willy

On Tue, Sep 02, 2003 at 02:35:32PM -0500, Joseph Pingenot wrote:
> Hello.
> 
> I'm getting lockups on my dual P3 Katmai system under 2.4.22.  It worked
>   fine with 2.4.21-pre4 (I had an uptime of about 130 or so days), but
>   I tried to upgrade to 2.4.22 and it's now started locking up.  I get
>   no Oops output or anything.  I've tried both the vanilla 2.4.22 and
>   the vanilla 2.4.23-pre1 kernels.
> Symptoms: screen will occasionally go blank for a split second, then
>   the system locks up after about half an hour to two hours (doesn't seem
>   to be a strict time).  When it locks up, I don't notice any LEDs on the
>   keyboard flashing, and I don't notice any other activity.  The Magic
>   SysRq sync and unmount keys have no effect, so far as I can tell.  It
>   seems to be truly locked up.  The reset button will, however, reset
>   the computer; I don't have to pull the plug.
> Any ideas on what might be causing this?  Anything I can do to get
>   a better idea what's going on?
> Thanks!
> 
> -Joseph
> 
> -- 
> trelane@digitasaru.net--------------------------------------------------
> "We continue to live in a world where all our know-how is locked into
>  binary files in an unknown format. If our documents are our corporate
>  memory, Microsoft still has us all condemned to Alzheimer's."
>     --Simon Phipps, http://theregister.com/content/4/30410.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
