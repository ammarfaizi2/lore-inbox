Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVADVRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVADVRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVADVQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:16:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39866 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262008AbVADVJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:09:16 -0500
Subject: Re: [PATCH] disallow modular capabilities
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0501041303190.2294@ppc970.osdl.org>
References: <20050102200032.GA8623@lst.de>
	 <1104870292.8346.24.camel@krustophenia.net>
	 <Pine.LNX.4.58.0501041303190.2294@ppc970.osdl.org>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 16:09:02 -0500
Message-Id: <1104872943.8346.30.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 13:05 -0800, Linus Torvalds wrote:
> 
> On Tue, 4 Jan 2005, Lee Revell wrote:
> > 
> > And I posted this to LKML almost a week ago, and a real fix was posted
> > in response.
> > 
> > http://lkml.org/lkml/2004/12/28/112
> 
> Well, I realize that it has been on bugtraq, but does that make it a real 
> concern? I'll make the tristate a boolean, but has anybody half-way sane 
> ever _done_ what is described by the bugtraq posting? IOW, it looks pretty 
> much like a made-up example, also known as a "don't do that then" kind of 
> buglet ;)

Well, a buglet is still a type of bug ;-)

What's wrong with Serge's patch?  I don't see any downside.

http://lkml.org/lkml/2004/12/29/59

Lee

