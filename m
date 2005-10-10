Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVJJKpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVJJKpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 06:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVJJKpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 06:45:45 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:15799 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750733AbVJJKpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 06:45:44 -0400
Message-ID: <434A4654.40607@andrew.cmu.edu>
Date: Mon, 10 Oct 2005 06:45:40 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jeff shia <tshxiayu@gmail.com>
CC: Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: What is the vanilla kernel?
References: <7cd5d4b40510091648ldabbd22g36ed34139e82fea8@mail.gmail.com>	 <5bdc1c8b0510091720m29b638fatf66375fabcecd7f2@mail.gmail.com> <7cd5d4b40510100325q730f710focecd05c05c2f56d@mail.gmail.com>
In-Reply-To: <7cd5d4b40510100325q730f710focecd05c05c2f56d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff shia wrote:
> I still have some questions.
> The stable kernel is called vanilla?but the file name is linux-version.tar.gz?
> Such as the kenrel linux-2.6.8.tar.gz can be called a vanilla?

The term "vanilla" is short for "plain vanilla", which means lacking in 
adornments or extra features.  It is derived from the use of vanilla as 
a basic flavor in deserts to which other optional flavors may be added. 
  For the kernel, vanilla simply refers to Linus' kernel with no extra 
patches applied to it.

Example:
   2.6.13 is a vanilla kernel
   2.6.13-rt3 is not (it's vanilla 2.6.13 + rt patches)

  - Jim Bruce
