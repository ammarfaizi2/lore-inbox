Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTKDJ2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTKDJ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:28:13 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:45061 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S264023AbTKDJ2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:28:12 -0500
Date: Tue, 4 Nov 2003 10:26:52 +0100
From: David Jez <dave.jez@seznam.cz>
To: Faisal Malallah <hitman1_fm@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.22 oops with visor.o and pppd
Message-ID: <20031104092652.GB35982@stud.fit.vutbr.cz>
References: <LAW9-F105snqHs4rVPX0001384e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LAW9-F105snqHs4rVPX0001384e@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I try to link my Palm Tungsten T to linux through USB using pppd to 
> establish a network connection, the connection goes well for a while but 
> then it disconnects and the kernel oops.
> 
> Using Kernel 2.4.22 on redhat 9
> pppd version 2.4.1
  Hi,

  Try update for newer redhat kernel or 2.4.23-pre5. Tt is fixed since
2.4.23-pre5.

-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
