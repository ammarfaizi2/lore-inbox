Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030516AbVIPAJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030516AbVIPAJA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 20:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbVIPAJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 20:09:00 -0400
Received: from smtpout.mac.com ([17.250.248.71]:62924 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965289AbVIPAI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 20:08:59 -0400
In-Reply-To: <200509152350.j8FNoTM17346@inv.it.uc3m.es>
References: <200509152350.j8FNoTM17346@inv.it.uc3m.es>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0CF04ACB-C931-4016-B50C-233FEA7AC78C@mac.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: .o.cmd files wanted, static analysis
Date: Thu, 15 Sep 2005 20:08:40 -0400
To: ptb@inv.it.uc3m.es
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15, 2005, at 19:50:29, Peter T. Breuer wrote:
> Does somebody out there have a pretty complete kernel compilation,  
> mainly all modules (though I don't care!), and could let me have  
> their .*.o.cmd files? In fact, just the FIRST LINE of them.

doesn't "make allmodconfig" work for you?  That should generate a  
config with everything possible included as modules, and then you can  
compile that to generate .cmd files.


Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


