Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261941AbREPNbw>; Wed, 16 May 2001 09:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261947AbREPNbm>; Wed, 16 May 2001 09:31:42 -0400
Received: from pc1-camb6-0-cust57.cam.cable.ntl.com ([62.253.135.57]:61063
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S261941AbREPNba>; Wed, 16 May 2001 09:31:30 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Nico Schottelius <nicos@pcsystems.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: parport problems with devfs 
In-Reply-To: Message from Nico Schottelius <nicos@pcsystems.de> 
   of "Wed, 16 May 2001 15:19:02 +0200." <3B027E46.5095E8BB@pcsystems.de> 
In-Reply-To: <3B027E46.5095E8BB@pcsystems.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 14:31:26 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E1501Og-0007EH-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I attached the problem occured with parport and devfs.
>I don't exactly know where the problem in the parport source
>is. If someone has a patch for it, I will test it.

I don't think this is a bug.  You need to load the `lp' module.

p.


