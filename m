Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263346AbUJ2On1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbUJ2On1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbUJ2OlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:41:18 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:54995 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S263347AbUJ2OeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:34:09 -0400
Date: Fri, 29 Oct 2004 16:33:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jan Kara <jack@suse.cz>
cc: M?ns Rullg?rd <mru@inprovide.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Configurable Magic Sysrq
In-Reply-To: <20041029133527.GA25172@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.53.0410291632310.16820@yvahk01.tjqt.qr>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
 <20041029024651.1ebadf82.akpm@osdl.org> <yw1xu0sdiwr2.fsf@inprovide.com>
 <20041029133527.GA25172@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >>    I know about a few people who would like to use some functionality of
>> >>  the Magic Sysrq but don't want to enable all the functions it provides.
>> >
>> > That's a new one.  Can you tell us more about why people want to do such a
>> > thing?

Like me, I only need sysrq's S, U, B and sometimes K ;-)
How much space does it take anyway for the other sysrqs?
If it's below 8K (arbitrarily chosen limit) then I can live with "all sysrqs"
being in.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
