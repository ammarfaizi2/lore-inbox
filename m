Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWIUJHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWIUJHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 05:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWIUJH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 05:07:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:31456 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751071AbWIUJH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 05:07:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=bD1XqMkBesKKVXU8He1SrV2QO5i7aEFfQ4aJ25xSsOJrpTGK54IIRkoftvy5XLAtevaj7uamqhJX22HTH1XqV1U89ik9NVxwIPLj8YkJw944NX+dLZkGSE09TKSaizSAdqNiXrGXdHy05xint99SJSTT6kFf8Dq+DS7tluAsD/8=
Date: Thu, 21 Sep 2006 11:06:21 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Florian Weimer <fweimer@bfk.de>, linux-kernel@vger.kernel.org
Subject: Re: Historic Linux 2.4 GIT repository
Message-ID: <20060921110621.GA1298@slug>
References: <82odt9obir.fsf@mid.bfk.de> <Pine.LNX.4.61.0609211048560.22923@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609211048560.22923@yvahk01.tjqt.qr>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 10:49:17AM +0200, Jan Engelhardt wrote:
> 
> >Is there a GIT repository with historic data, from the 2.5 branch
> >point until the start of Marcelo's (converted?) repository?  If yes,
> >what's its URL?
> 
> I think no, the first GIT shot being 2.6.12, IIRC.
There's an old-2.6-bkcvs tree:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git;a=tags
which holds information from the 2.5 trees.

Regards,
Frederik
> 
> 
> 
> Jan Engelhardt
> -- 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
