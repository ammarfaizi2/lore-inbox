Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTJSPog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTJSPof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:44:35 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:17679 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261437AbTJSPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:44:34 -0400
Date: Sun, 19 Oct 2003 17:36:50 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Console escape sequences
Message-ID: <20031019153650.GG24310@DervishD>
References: <20031018000531.GB17198@DervishD> <20031018112330.GH17198@DervishD> <20031019112647.GA8497@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031019112647.GA8497@babylon.d2dc.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Zephaniah :)

 * Zephaniah E. Hull <warp@babylon.d2dc.net> dixit:
> >     Is there any more up to date reference or any place in the source
> > code? Thanks for the answer anyway :))) and thanks in advance for all
> > your help, together with my excuses to the two persons who answered
> > for having lost their emails.
> The code that seems to handle it in 2.6.0-test7-mm1 is in
> drivers/char/vt.c, starting in do_con_write and actually dealt with in
> do_con_trol.

    Thanks a lot, I'll take a look :)))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
