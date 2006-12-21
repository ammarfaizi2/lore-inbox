Return-Path: <linux-kernel-owner+w=401wt.eu-S1423028AbWLUWgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbWLUWgs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423089AbWLUWgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 17:36:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:25713 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423028AbWLUWgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 17:36:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gezsEjO1feOQViWKFKnR3CMlPdW9XLJUVbvuS/k+OaFOYAykobRknUi/cRJ7++f8rZUT1sgXVjmwm7jBP07eGLAsNHCEjZSodMc1jbcYdGnWZTB0wsRyemT/HLXmGEteBl6k9ft7TMo8U2So+6vHwzAuhlC3Cwquy+7D454kdSE=
Message-ID: <161717d50612211436s4595c873j95d4091ba622d4bc@mail.gmail.com>
Date: Thu, 21 Dec 2006 17:36:45 -0500
From: "Dave Neuer" <mr.fred.smoothie@pobox.com>
To: "Tomas Carnecky" <tom@dbservice.com>
Subject: Re: Binary Drivers
Cc: "James Porter" <jameslporter@gmail.com>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       "Scott Preece" <sepreece@gmail.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Alexey Dobriyan" <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <458AE3B7.8080302@dbservice.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <loom.20061215T220806-362@post.gmane.org>
	 <20061215220117.GA24819@martell.zuzino.mipt.ru>
	 <4583527D.4000903@dbservice.com>
	 <m13b7ds25w.fsf@ebiederm.dsl.xmission.com>
	 <7b69d1470612210833k79c93617nba96dbc717113723@mail.gmail.com>
	 <20061221174346.GN3073@harddisk-recovery.com>
	 <458ADC37.9070608@dbservice.com>
	 <f0e2c5070612211120wa6e3402p2ffb6e1d579a485a@mail.gmail.com>
	 <458AE3B7.8080302@dbservice.com>
X-Google-Sender-Auth: 0ba8b2dc4e54fa3f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Tomas Carnecky <tom@dbservice.com> wrote:
> James Porter wrote:
> > I'm pretty sure Linus has decided, basically he said the patches to
> > prevent non-gpl binary drivers are not going into his tree unless every
> > other tree adopts it. Of course the few supporting won't get off their
> > high horse and try it on a different tree.
>
> .. unfortunately, that doesn't make the legal status any clearer.

Well, FWIW, neither does some "decision" from the kernel authors; it
hinges on what is and what is not a derived work of the kernel, and
the only parties whose opinion matters here (the courts in the various
jurisdictions) haven't ruled on that yet, and won't until such time as
a copyright holder in the kernel sues someone for copyright
infringement.

Dave
