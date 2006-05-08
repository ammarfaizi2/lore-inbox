Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWEHRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWEHRsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWEHRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:48:22 -0400
Received: from hera.kernel.org ([140.211.167.34]:57828 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932451AbWEHRsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:48:22 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Bugs aren't features: X86_FEATURE_FXSAVE_LEAK
Date: Mon, 8 May 2006 10:47:58 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e3o08e$jm1$1@terminus.zytor.com>
References: <69bvw-2zO-5@gated-at.bofh.it> <69d4M-4Yx-19@gated-at.bofh.it> <69mqY-1Ci-9@gated-at.bofh.it> <445CDED0.4070402@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1147110478 20162 127.0.0.1 (8 May 2006 17:47:58 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 8 May 2006 17:47:58 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <445CDED0.4070402@shaw.ca>
By author:    Robert Hancock <hancockr@shaw.ca>
In newsgroup: linux.dev.kernel
> > 
> > I have a dual CPU system (Tyan Tomcat 1564D) where only one CPU is
> > reported to have the F00F bug (iirc).  So yes, there can be
> > SMP-systems where the CPU's have different bugs.
> 
> Point being, not this bug..
> 

However, *MY* point is that we should have a uniform infrastructure
for bugs, just like we now have for features.

	-hpa

