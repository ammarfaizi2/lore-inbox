Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135248AbRDRS3v>; Wed, 18 Apr 2001 14:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135247AbRDRS3m>; Wed, 18 Apr 2001 14:29:42 -0400
Received: from monza.monza.org ([209.102.105.34]:30477 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132507AbRDRS3Z>;
	Wed, 18 Apr 2001 14:29:25 -0400
Date: Wed, 18 Apr 2001 11:29:10 -0700
From: Tim Wright <timw@splhi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5 Workshop RealVideo streams -- next time, please get better  audio.
Message-ID: <20010418112910.A1761@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
In-Reply-To: <m1lmoys7wt.fsf@frodo.biederman.org> <E14prJy-0004eW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14prJy-0004eW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Apr 18, 2001 at 01:44:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So grab and install dsproxy (http://freshmeat.net/projects/dsproxy/), and
capture the output. Than feed to e.g. XMMS which already has an AGC plugin.

t

On Wed, Apr 18, 2001 at 01:44:32PM +0100, Alan Cox wrote:
> > So my question is, what would it take to get some automatic software
> > volume correction going.  This looks like it would be the easiest fix
> > of all.
> 
> Unfortunately its encoded in a proprietary format otherwise it would have
> been perhaps half an hours work to write an AGC filter for the data.
> 
> Alan
> 
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
