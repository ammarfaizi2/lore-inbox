Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbTGOMtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbTGOMtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:49:52 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:4324 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S268095AbTGOMsE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:48:04 -0400
Message-ID: <3F13FC0E.3020006@free.fr>
Date: Tue, 15 Jul 2003 15:05:18 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ajoshi@kernel.crashing.org
Cc: benh@kernel.crashing.org, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: About Radeonfb : Please improve the driver efficiently instead of
 arguing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ani,

I've seen your mails on LKML. I've also been using Ben's patch on my 
laptop happily for months. I do not want to argue which is right or 
wrong but just point out some facts :

	- ATI embbeded controller is one of the most used for laptop (Ix86 and 
Macs), so having a good driver is indeed very important so please work 
toghether,
	- I've seen Ben's official announcement for his patch on LKML and 
applied the patch. I guess a *maintainer* should have been able to also 
see it and incorporate it or at least argues why he doesn't agree with 
proposed changes. I've haven't seen any public reply from you Ani to 
ben's original post,
	- You pretend 0.18 includes all ben's work which is apparently not 
true. This is at least misleading,

So, from theses pure facts, I would suggest that you :

	- Improve at least the way you communicate with others trying to 
enhance the radeonfb driver even if its not their main job. What would 
have happened to linux if Linus or Allan would have refused patches 
coming from outside...
	- enhance *efficiently* the radeonfb driver instead of arguing over 
maintenance ownership...

A not so happy radeonbf user,

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

