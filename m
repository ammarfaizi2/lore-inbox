Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTDYRzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 13:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTDYRzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 13:55:49 -0400
Received: from AMarseille-201-1-6-40.abo.wanadoo.fr ([80.11.137.40]:26151 "EHLO
	gaston") by vger.kernel.org with ESMTP id S263381AbTDYRzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 13:55:48 -0400
Subject: Re: :(((((((
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valdis.Kletnieks@vt.edu
Cc: Balram Adlakha <b_adlakha@softhome.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200304251608.h3PG8BQd006090@turing-police.cc.vt.edu>
References: <200304252118.34547.b_adlakha@softhome.net>
	 <200304251608.h3PG8BQd006090@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051294068.10342.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 20:07:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-25 at 18:08, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 25 Apr 2003 21:18:34 +0530, Balram Adlakha <b_adlakha@softhome.net>  said:
> > when will I see a native linux kernel module for Nvidia based cards? I'm sick
>  
> > of the nvidia.com one.
> 
> Feel free to take the open-source 'nv' driver from the XFree86 4.3.0 tree
> and figure out how to put it into the kernel.  Figuring out how to splice
> the licenses is the tricky part. ;)

That's +/- what rivafb already is. I have a version in my tree that
has some more updates from XFree that I intend to submit after 2.4.21

Ben.

