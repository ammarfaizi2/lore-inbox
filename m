Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVKTCXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVKTCXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 21:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVKTCXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 21:23:16 -0500
Received: from eastrmmtao03.cox.net ([68.230.240.36]:43488 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751145AbVKTCXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 21:23:16 -0500
In-Reply-To: <53045.69.50.231.5.1132452579.squirrel@mail.ctyme.com>
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain> <200511191900.12165.s0348365@sms.ed.ac.uk> <1132431907.19692.15.camel@localhost.localdomain> <20051120015924.GE20828@ime.usp.br> <53045.69.50.231.5.1132452579.squirrel@mail.ctyme.com>
Mime-Version: 1.0 (Apple Message framework v734)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <66529887-BC75-4116-AB29-32CC54A0C438@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: resyncing broken software raid 1
Date: Sat, 19 Nov 2005 21:23:45 -0500
To: Marc Perkel <marc@perkel.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19, 2005, at 21:09:39, Marc Perkel wrote:

> OK - I must be blind but what do you do in FC4 to resync a borken  
> raid 1 array? It's software raid. I thought it was raidhotadd but  
> can't get that to work.
>

Please create a new thread (instead of responding to a message in an  
existing thread) when you want to discuss a new topic.

See "man mdadm" for more info, raidtools have been deprecated for a  
long time.

Cheers,
Kyle Moffett


