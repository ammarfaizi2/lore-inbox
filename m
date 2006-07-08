Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWGHLQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWGHLQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWGHLQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:16:08 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:39832 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S964775AbWGHLQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:16:06 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Bojan Smojver <bojan@rexursive.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Rychter <jan@rychter.com>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <20060708111359.GJ1700@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com>
	 <1152353698.2555.11.camel@coyote.rexursive.com>
	 <1152355318.3120.26.camel@laptopd505.fenrus.org>
	 <1152357077.2088.4.camel@beast.rexursive.com>
	 <20060708111359.GJ1700@elf.ucw.cz>
Content-Type: text/plain
Organization: Rexursive
Date: Sat, 08 Jul 2006 21:16:03 +1000
Message-Id: <1152357363.2088.9.camel@beast.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 13:13 +0200, Pavel Machek wrote:

> Then you need to read suspend2 patch again.

Didn't Nigel already explain that the kernel only passes the messages to
userspace, but doesn't actually do any "painting"?

-- 
Bojan

