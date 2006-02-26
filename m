Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWBZVb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWBZVb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWBZVb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:31:28 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:330 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751257AbWBZVb2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:31:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MMPfmje2idqHMZBvkyBiJYVPWW8RONdkjc7y8blSRiVOefHxoU5nUlI/3mlxb3+mdkXOtFgSup2iKJXo2H0RmMyUazdkyTmkR/56rG66QB3I9MQgmODrvf9JRWEM3WOwp94lntCg3ubUJiSrmYuN/1j52oqAsGhJK/6sQQTOWgc=
Message-ID: <21d7e9970602261331n128d50f3g55af85d7c8c27f93@mail.gmail.com>
Date: Mon, 27 Feb 2006 08:31:26 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: old radeon latency problem still unfixed?
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Dave Airlie" <airlied@linux.ie>
In-Reply-To: <1140982763.24141.123.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140917787.24141.78.camel@mindpipe>
	 <20060226014437.327b1cc3.akpm@osdl.org>
	 <1140947860.2934.12.camel@laptopd505.fenrus.org>
	 <1140982763.24141.123.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks I will check on this.
>

I don't suppose they are running with X renice -10?

or some such.. that was done by a few vendors previously.. if X is
using hw accel, then it will be in the DRM driver a bit...

Dave.
