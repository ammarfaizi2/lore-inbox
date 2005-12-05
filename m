Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVLEX0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVLEX0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVLEX0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:26:15 -0500
Received: from main.gmane.org ([80.91.229.2]:22507 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964862AbVLEX0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:26:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Tue, 06 Dec 2005 00:24:42 +0100
Message-ID: <pan.2005.12.05.23.24.41.945679@free.fr>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, 05 Dec 2005 11:52:32 +0100, Arjan van de Ven a écrit :

> Linux in a binary world
> 
> 
> What if.. what if the linux kernel developers tomorrow accept that
> binary modules are OK and are essential for the progress of linux. 
> 
[...]
> Now this scenario may sound unlikely to you. And thankfully the main
> assumption (the December 6th event) is extremely unlikely.  
> 
> However, and this unfortunately, several of the other "leaps" aren't
> that unlikely. In fact, some of these results are likely to happen
> regardless; witness the flamewars on lkml about breaking module API/ABI.
> Witness the ndiswrapper effect of vendors now saying "we support linux
> because ndiswrapper can use our windows driver". I hope they won't
> happen. Some of that hope will be idle hope, but I believe that the
> advantages of freedom in the end are strong enough to overcome the
> counter forces.
And some embedded companies provide the minimal source code to put 
in arch and everything else (ethernet, adsl, wifi, ...) is binaries
modules.

