Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTLZBwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 20:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbTLZBwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 20:52:18 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:31658 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S264451AbTLZBwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 20:52:14 -0500
From: Eric <eric@cisu.net>
To: dan@eglifamily.dnsalias.net
Subject: Re: 2.6.0 problems
Date: Thu, 25 Dec 2003 19:52:27 -0600
User-Agent: KMail/1.5.94
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312260106510.1888-100000@eglifamily.dnsalias.net>
In-Reply-To: <Pine.LNX.4.44.0312260106510.1888-100000@eglifamily.dnsalias.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312251952.27057.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 December 2003 07:07 pm, dan@eglifamily.dnsalias.net wrote:

>Any ideas on the blank screen issue?
>
> --- Dan
Oops, lol didn't see your other issue. Well, personally I haven't had any luck 
with bootup logos. However Im pretty sure if you disable framebuffer console
CONFIG_FRAMEBUFFER_CONSOLE=n
then you'll get your screen back. I have trouble with the FB options, so i 
cant recommend a better fix other than to not use it ;)

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
