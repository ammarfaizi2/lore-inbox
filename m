Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136550AbRD3XrJ>; Mon, 30 Apr 2001 19:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136549AbRD3Xqs>; Mon, 30 Apr 2001 19:46:48 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:2314 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136548AbRD3Xqq>;
	Mon, 30 Apr 2001 19:46:46 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] [PATCH] automatic multi-part link rules (fwd) 
In-Reply-To: Your message of "Tue, 01 May 2001 01:31:20 +0200."
             <20010501013120.A15120@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 May 2001 09:46:39 +1000
Message-ID: <16913.988674399@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001 01:31:20 +0200, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>On 05.01 Keith Owens wrote:
>> The patch appears to work but is it worth applying now?  The existing
>> 2.4 rules work fine and the entire kbuild system will be rewritten for
>> 2.5
>
>We will have to live with 2.4 until 2.6, 'cause 2.5 will not be stable.
>2.4 will be the stable and non "brain damaged" kernel in distros.
>So every thing that can make 2.4 more clean, better. Think in 2.4.57,
>and we still are in 4. And feature backports, and new drivers...
>The 2.5 rewrite is not excuse. The knowledge on the actual state, yes.

But 2.4 kbuild for multi part objects already works, there is no bug to
fix or live with.  2.4 is supposed to be bug fixes only.  IMHO keeping
the existing boilerplate method for multi part objects in 2.4 is the
safer approach, don't rock the boat.

