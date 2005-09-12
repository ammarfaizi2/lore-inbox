Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVILBmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVILBmt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 21:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVILBmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 21:42:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32652 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751127AbVILBms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 21:42:48 -0400
Subject: Re: [Alsa-devel] Re: Brand-new notebook useless with Linux...
From: Lee Revell <rlrevell@joe-job.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@alsa-project.org>
In-Reply-To: <200509091411_MC3-1-A9B0-1C0C@compuserve.com>
References: <200509091411_MC3-1-A9B0-1C0C@compuserve.com>
Content-Type: text/plain
Date: Sun, 11 Sep 2005 21:42:44 -0400
Message-Id: <1126489364.5619.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 14:09 -0400, Chuck Ebbert wrote:
> In-Reply-To: <1126207905.12697.20.camel@mindpipe>
> 
> On Thu, 08 Sep 2005 at 15:31:44 -0400, Lee Revell wrote:
> 
> > Wait, that sounds like the modem, not the AC97 audio codec.
> >
> > You might be able to get the modem to work with the (proprietary)
> > slmodem software modem, or something.  I wouldn't count on it though.
> > 
> > Does your sound work?
> 
> 
>  Well I'll be...
> 
>  I'd assumed from the (confusing) messages that the sound card was
> not working, but it seems fine.  Shouldn't the error messages from
> atiixp-modem be prefixed with that name instead of "atiixp"?
> 
> Untested patch follows.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

This should be applied IMO.  Can we get it in CVS?

Lee

