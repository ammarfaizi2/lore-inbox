Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRBMDZE>; Mon, 12 Feb 2001 22:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRBMDYz>; Mon, 12 Feb 2001 22:24:55 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:35363 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129165AbRBMDYu>; Mon, 12 Feb 2001 22:24:50 -0500
Message-ID: <3A88A87F.BBB0B6EF@redhat.com>
Date: Mon, 12 Feb 2001 22:22:39 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Carlos Carvalho <carlos@fisica.ufpr.br>
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre9 Kernel panic aic7xxx
In-Reply-To: <3A8450B0.D2B85951@dial.eunet.ch>
		<3A84640B.6F0D31D5@redhat.com> <14983.57112.764892.252275@hoggar.fisica.ufpr.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Carvalho wrote:
> 
> Doug Ledford (dledford@redhat.com) wrote on 9 February 2001 16:41:
>  >The latest patch I sent Alan had both the hosts.c fix and some other fixes, so
>  >I'm thinking it hasn't made it into his 2.2.19pre9 kernel.  The next one
>  >should work fine as far as aic7xxx is concerned.
> 
> I think you should post your patch here, because pre9 is unusable
> without it. Well, at least for me, but this is the first time in
> almost 9 years that this happens. I have fairly standard 7890, in
> 2940, 2940UW adaptecs. If it doesn't work for me, it's likely to not
> work for many others. Since pre9 is urgent because of the security
> patches, it'd be good to upgrade as soon as possible.
> 
> Another alternative is that Alan posts the security part separately.
> Or that he releases pre10, including all Trond's fixes for nfs as
> well :-) :-)

The patches needed to get the aic7xxx driver working with 2.2.19-pre9 are now
up on my web page (see my sig).

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
