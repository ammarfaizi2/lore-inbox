Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVLBUy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVLBUy6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVLBUy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:54:58 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:35647 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751069AbVLBUy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:54:58 -0500
Subject: Re: forcedeth
From: Kasper Sandberg <lkml@metanurb.dk>
To: Jacques de Krahe <dekrahe@tiscali.be>
Cc: c-d hailfinger <linux-kernel@vger.kernel.org>,
       hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
In-Reply-To: <1133554191.4786.8.camel@localhost.localdomain>
References: <1133554191.4786.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 21:54:52 +0100
Message-Id: <1133556892.16820.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 21:09 +0100, Jacques de Krahe wrote:
> Running FC4 on a PC equipped with NForce2 chipset and AMD k7 (Athlon XP
> 2200) 
> The eth interface can't be normally configured at boot and fails.
> The problem comes from forcedeth. The system asks me to have a look into
> dmesg, where I find a line that reads a follows: forcedeth : Unknown
> parameter "irq"
are you trying to load forcedeth with a parameter called "irq" ? if so,
try without

> The next line in /var/log/dmesg shows the version number.
> Is it possible to correct the code and what are the necessary steps to
> get a functional module?
> If you answer my question, please be as complete as possible, I am a new
> user of FC4.
> Thank in advance
> Regards
> Jacques de Krahe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

