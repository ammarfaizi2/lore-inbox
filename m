Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUBQXpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUBQXpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:45:22 -0500
Received: from netline-mail1.netline.ch ([195.141.226.27]:59152 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S266780AbUBQXoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:44:19 -0500
Subject: Re: radeon warning on 64-bit platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: davidm@hpl.hp.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <16434.41884.249541.156083@napali.hpl.hp.com>
References: <16434.35199.597235.894615@napali.hpl.hp.com>
	 <1077054385.2714.72.camel@thor.asgaard.local>
	 <16434.36137.623311.751484@napali.hpl.hp.com>
	 <1077055209.2712.80.camel@thor.asgaard.local>
	 <16434.37025.840577.826949@napali.hpl.hp.com>
	 <1077058106.2713.88.camel@thor.asgaard.local>
	 <16434.41884.249541.156083@napali.hpl.hp.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077061456.16774.19.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 00:44:16 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,


looks good to me, except for a detail:

> +		 * Michael Dänzer, the ioctl() is only used on embedded platforms, so not
                     ^^^^^^^
That's not quite my first name. :)


I'd appreciate a heads up when this (or whatever becomes of it) goes in
so I can apply it to DRI CVS as well. On the other hand, I'll probably
see it at the latest when Ben merges it into his tree. :)


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

