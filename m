Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRBTCmf>; Mon, 19 Feb 2001 21:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRBTCmZ>; Mon, 19 Feb 2001 21:42:25 -0500
Received: from [209.102.105.34] ([209.102.105.34]:18956 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129309AbRBTCmJ>;
	Mon, 19 Feb 2001 21:42:09 -0500
Date: Mon, 19 Feb 2001 18:41:29 -0800
From: Tim Wright <timw@splhi.com>
To: Juergen Schoew <Juergen.Schoew@unix-ag.uni-siegen.de>
Cc: Thomas Lau <lkthomas@hkicable.com>, linux-kernel@vger.kernel.org
Subject: Re: finding Tekram SCSI dc395U linux patch driver:
Message-ID: <20010219184129.A1075@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Juergen Schoew <Juergen.Schoew@unix-ag.uni-siegen.de>,
	Thomas Lau <lkthomas@hkicable.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A8C3DA1.F8E2CE09@hkicable.com> <XFMail.010215224622.Juergen.Schoew@unix-ag.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.010215224622.Juergen.Schoew@unix-ag.org>; from Juergen.Schoew@unix-ag.uni-siegen.de on Thu, Feb 15, 2001 at 10:46:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I asked Kurt why it was not submitted to the mainstream kernel. He said that
some people are still experiencing problems with the card/driver and he doesn't
feel it's stable enough to go in. I'm personally using it with no issues, but
I'm only driving a CD-RW - not exactly stressing things.

It sounds like the people having issues need to debug the problems, or maybe
it could go in under CONFIG_EXPERIMENTAL ?

Tim

On Thu, Feb 15, 2001 at 10:46:22PM +0100, Juergen Schoew wrote:
> Hi,
> On 15-Feb-01 Thomas Lau wrote:
> > hey, I found this driver on mandrake kernel sources, it's ac3, but I
> > need ac14 code, also, why still not port this driver into kernel?
> > the patch file already released 1 years ago
> 
> Have you checked http://www.garloff.de/kurt/linux/dc395/index.html
> there ist a driver Version 1.32 (2000-12-02).
> 
> Regards 
> 
> Juergen Schoew
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
