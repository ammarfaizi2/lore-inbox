Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTFULh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbTFULh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 07:37:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9415
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265145AbTFULhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 07:37:25 -0400
Subject: Re: [SIS IDE] Enhanced SiS96x support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <3EF0FC4E.4090805@inet6.fr>
References: <3EF0FC4E.4090805@inet6.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056196155.25974.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 12:49:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-06-19 at 00:57, Lionel Bouton wrote:
> For the 2.5 tree, I'll check the latest 2.5-bk and 2.5-ac state tomorrow 
> (need some sleep). I see 2.5-ac is laging behind (.69 vs .72), do you 
> want me to push a patch to Linus directly or to you first ? If you want 
> it first, against 2.5-bk or -ac (or both) ?

2.5-ac is defunct for the moment due to the amount of 2.4 stuff I need to
get done and fixed up. For 2.5 IDE send it to Bartlomiej who is now 2.5
IDE maintainer and doing wonders

