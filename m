Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVCWUlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVCWUlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCWUlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:41:13 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:45643 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262920AbVCWUkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:40:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RmtSy6UQ4uPgRhfh0PdterrxnS+N9H9vYtm0RcfnrK5s7Xtrmxbf0K+xvrRmoMv/l44DQmaGCNk3nWnYF8EISxD39MrOqDGkq8PwoV9ZBsGHx1QfS3q6zPonXC2c3/FhoESw47XxbZBQCJmuVpgAZtpM3RVebV37fYc/DJNCapk=
Message-ID: <21d7e99705032312406fb8ac9a@mail.gmail.com>
Date: Thu, 24 Mar 2005 07:40:43 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: X not working with Radeon 9200 under 2.6.11
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, airlied@linux.ie
In-Reply-To: <20050323123641.65ab0c91.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <16937.54786.986183.491118@ccs.covici.com>
	 <20050321145301.3511c097.akpm@osdl.org>
	 <16959.25374.535872.507486@ccs.covici.com>
	 <20050321162214.71483708.akpm@osdl.org>
	 <21d7e9970503231150263cfc5e@mail.gmail.com>
	 <20050323123641.65ab0c91.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  > Do we know what changed to cause this?  Was it deliberate?
> >
> >  If I was a guessing man and I am due to lack of time.. I'd say the
> >  address space layout changes ..
> 
> Ow.  I never saw any such reports.

as I said only a guess .. when someone mentions 2.6.9 to me I always
think address space changes :-)

I've hopefully got a full day barring jetlag to try and get the 2.6
drm straightened out.. of course on my machine it all works
wonderfully... so I need to get more machines :-)

Dave.
