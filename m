Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271806AbTGRPGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271842AbTGRPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:06:18 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:23058 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S271764AbTGROyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:54:04 -0400
Date: Fri, 18 Jul 2003 17:10:13 +0200
From: DervishD <raul@pleyades.net>
To: joe briggs <jbriggs@briggsmedia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: run-parts,find, kupdated: What are they and how to control them?
Message-ID: <20030718151013.GB3963@DervishD>
References: <200307180925.24867.jbriggs@briggsmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200307180925.24867.jbriggs@briggsmedia.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Joe :)

 * joe briggs <jbriggs@briggsmedia.com> dixit:
> Can someone 
> PLEASE either explain what these are doing and how they are controlled, or 
> point me in the right direction? Many thanks.

    Your problem has nothing to do with the kernel itself. Your
problem is that you have cron jobs that eat resources. If you don't
want them, just disable cron, or delete the cron jobs, etc...

    Without knowing your distro, your cron config or more details for
you system I cannot tell you more. Just in case, find is a binary
for... finding files; run-parts is for running things in your
/etc/rc* directories and kupdated is the buffer cache manager (well,
more or less...). BTW, googling for 'kupdated' shows a lot of info...

    I don't know of a mailing list related to this kind of questions,
so I think this can be as good as any. If you want more help you will
have to give me more information about your problem.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
