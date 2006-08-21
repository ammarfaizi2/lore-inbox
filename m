Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWHUJcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWHUJcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWHUJcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:32:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:32822 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751063AbWHUJcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:32:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=ar8rsV1gUem+BWO6KGsFaVHMbpoZRmrBPkp6tLnTLputE2OhJH0N2RsAcZOOuChHI6RAj4GU2gN7f+dCktYXDs8SNO/c2M3ah3Rngi7GKFq0qsWwtpM+gKwBzfDazSGyRUL6P63zQdEq3qH/tIvUCFhOOrh49PRZXifxTpUMb0g=
Date: Mon, 21 Aug 2006 11:32:39 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Gregoire Favre <gregoire.favre@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm2
Message-ID: <20060821113239.GA1919@slug>
References: <20060819220008.843d2f64.akpm@osdl.org> <20060821081216.GA9194@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060821081216.GA9194@gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:12:16AM +0200, Gregoire Favre wrote:
> Hello,
> 
> like thunder7@xs4all.nl wrote :
> "Also, it stil has the funny fast moving clock on x86-64"
> As I already repported for 2.6.18.rc4-mm1 playing video too fast, I
> suffer from the same problem.
> 
> I put under http://gregoire.favre.googlepages.com/linux all the config I
> could think about in order to help find out where the problem came from.
> 
> I could add anything wanted, just CC to me as I am not under this ml.
A patch is available in the hotfixes directory, have you tried it?

Regards,
Frederik
> 
> Thank you very much,
> -- 
> Grégoire FAVRE  http://gregoire.favre.googlepages.com  http://www.gnupg.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
