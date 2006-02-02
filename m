Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423028AbWBBGjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbWBBGjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 01:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423022AbWBBGji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 01:39:38 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:16164 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423031AbWBBGjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 01:39:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=rKLdzkmf+dJLGtXpmUT5pWvLVdZ4nOMUvKILe5z+RwdFLa3U2xyTBUvnNSCT+ywrpTw7ZycuO/nFqVQX2z7mmgI1scibujxuqdyltFkNQN4UnYHDBE4wylGTfWxtJI/9UMcpGvk4SOZ/bS3nYqLajKMDGbjfpMaMPJApuw/e5Tw=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Thu, 2 Feb 2006 01:39:25 -0500
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43D114A8.4030900@wolfmountaingroup.com> <Pine.LNX.4.64.0602011334270.21884@g5.osdl.org> <43E14451.1010100@keyaccess.nl>
In-Reply-To: <43E14451.1010100@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602020139.26065.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 18:29, Rene Herman wrote:
> There are two things here that need seperating. On the one hand, we have 
> "the program". On the other we have "the license" (and license notices). 
> The GPL requires you to be able to make changes to the program,

... Subject to the terms of Section 1. It says so explicitly: 
"You may ... under the terms of Section 1 above, provided that you also ..."
The GPL requires you to be able to make changes to the program _except_
for changes that would not "keep intact all the notices that refer to this
License" (+ a couple of other exceptions). Editing the text of the GPL in
the COPYING file would certainly violate this. However, copying COPYING
to a new file (license_for_foo, say) and editing that copy wouldn't. The
GPL allows this, the GPL's license does not, ergo, in the final analysis
I think you are right that the GPL's license is not literally
GPL-compatible.

> > This can, btw, also be shown independently by the fact that the FSF 
> > clearly _intended_ the license to be actively linked into the
> > program: they ask you (in the "How to Apply These Terms to Your New
> > Programs") to have commands to view parts of the license if your
> > program is interactive.
> 
> This, in fact, seems to be a good point. This one wants an FSF lawyer.

There is a very strong implication there that the GPL can be incorporated
into GPLed code. I'd read it as allowing the GPL v 2 to be included in
GPLed source code notwithstanding Section 2. It'd be nice if that were
explicit and part of the Terms and Conditions, but the verbiage is part of
the License, and I suspect counts for something. But IANAL.

As a practical matter, even if the GPL is technically GPL-incompatible,
the chances of anyone objecting to their GPLed code rubbing shoulders
with the GPL is remote.

Andrew Wade
