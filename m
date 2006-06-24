Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWFXOIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFXOIB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 10:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWFXOIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 10:08:01 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:29817 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWFXOIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 10:08:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D4X2NCaPOVQxaVcFECZDYA8iXI5frVTUnuQjrCwe4t3oP/olJhoTFvMnMyvze4cr2UaGz1TOIyFEqtwncagx23K8YB0sBhgnbgnHBGGJpn3voIhUpFQ9+TeC9rJFr9AaJ1C4SKgMlt6kbpQXbG0wsIfLJcQf9yYnV12xs0weyfc=
Message-ID: <32124b660606240708h3db66c3ds233c1da7696ead9e@mail.gmail.com>
Date: Sat, 24 Jun 2006 16:08:00 +0200
From: "Jacek J" <69rydzyk69@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: sound skips on 2.6.16.17
In-Reply-To: <20060620193620.GA24097@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4487F942.3030601@att.net.mx>
	 <200606181204.29626.ocilent1@gmail.com>
	 <20060618044047.GA1261@tuatara.stupidest.org>
	 <200606191154.33747.ocilent1@gmail.com>
	 <1150752280.2754.38.camel@mindpipe>
	 <20060619215023.GA1424@tuatara.stupidest.org>
	 <1150828530.2754.135.camel@mindpipe>
	 <20060620193620.GA24097@tuatara.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Chris Wedgwood <cw@f00f.org> wrote:
> On Tue, Jun 20, 2006 at 02:35:29PM -0400, Lee Revell wrote:
>
> > I see that no fix made it into 2.6.17.1 or 2.6.16.22.
>
> both came out very quickly and i was waiting on the results from a
> couple of people
>
> > What is the downside of simply reverting the patch that introduced the
> > regression?
>
> it breaks for some other people, it's not clear what the 'right' fix
> here should be, but it might end up being the lesser of two evils
>
> it would be *really* nice if someone from VIA could weigh in here
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
