Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbUDOVKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUDOVKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:10:32 -0400
Received: from smtp.rol.ru ([194.67.21.9]:25940 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S263574AbUDOVK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:10:27 -0400
From: Konstantin Sobolev <kos@supportwizard.com>
Reply-To: kos@supportwizard.com
Organization: SupportWizard
To: Pavel Machek <pavel@suse.cz>
Subject: Re: poor sata performance on 2.6
Date: Fri, 16 Apr 2004 01:13:10 +0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <200404150236.05894.kos@supportwizard.com> <20040415195053.GP468@openzaurus.ucw.cz>
In-Reply-To: <20040415195053.GP468@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404160113.10553.kos@supportwizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 23:50, Pavel Machek wrote:
> > /dev/hde:
> >  Timing buffer-cache reads:   1436 MB in  2.00 seconds = 717.03 MB/sec
> >  Timing buffered disk reads:  100 MB in  3.03 seconds =  32.95 MB/sec
>
> 33MB/sec "totally unacceptable"? Wow.
well.. taking into account it's price and final 68MB/sec I've got after 
following Justin's advice.. :)
-- 
/KoS
* Jeez, if you love Honkus...					      
