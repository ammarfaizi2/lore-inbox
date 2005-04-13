Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVDMQDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVDMQDj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVDMQDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:03:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31921 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261381AbVDMQDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:03:36 -0400
Date: Wed, 13 Apr 2005 18:03:30 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Oliver Korpilla <Oliver.Korpilla@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GNU/Linux userland?
Message-ID: <20050413160330.GA17778@pasky.ji.cz>
References: <425D75AF.7080802@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D75AF.7080802@gmx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 09:40:31PM CEST, I got a letter
where Oliver Korpilla <Oliver.Korpilla@gmx.de> told me that...
> Hello!

Hello,

> I wondered if there is a project or setup that does allow me to build a 
> GNU/Linux userland including kernel, build environment, basic tools with 
> a single script just as you can in NetBSD (build.sh) or FreeBSD (make 
> world).

Gentoo? :-) Bootstrap in particular, and emerge --emptytree system then.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
