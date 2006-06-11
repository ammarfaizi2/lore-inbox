Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWFKErF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWFKErF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 00:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWFKErF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 00:47:05 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:38745 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932101AbWFKErE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 00:47:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Men6yphFgr72a1Kvi9aRwkCeqGzijg0wv5Rz0tClsZmIWVvGxj9JIS4wMb8qa5pqaU7SuJ3hoMByvkL8P2N5EoZHE7BnZLpa+ByGirOdbkgIm7HxMIR7YCo7v0BArvpTVMfozoRc32waacHbDgIoYlxtCJpcpceICF7ZKTOhmdI=
Message-ID: <448BA03B.6060800@gmail.com>
Date: Sun, 11 Jun 2006 12:46:51 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
References: <44893407.4020507@gmail.com> <448AC8BE.7090202@gmail.com>	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	 <448B38F8.2000402@gmail.com>	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	 <448B61F9.4060507@gmail.com>	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>	 <448B6ED3.5060408@gmail.com>	 <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>	 <448B8818.1010303@gmail.com> <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
In-Reply-To: <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> My point is: 'Multiple active drivers feature' is a natural consequence
>> of the evolution of the code, but the only way to take advantage of it
>> is if we provide a means for the user to use it.  And we are not
>> providing the means.

Maybe you're misunderstanding me. When I say "we are not providing the
means", I mean "we are definitely not going to provide the means", NOT,
"so we should be providing the means".

Tony
