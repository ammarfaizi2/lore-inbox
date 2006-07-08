Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWGHKPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWGHKPB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWGHKPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:15:01 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:39300 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S932208AbWGHKPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:15:00 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Bojan Smojver <bojan@rexursive.com>
To: Jan Rychter <jan@rychter.com>
Cc: Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <m2d5cg1mwy.fsf@tnuctip.rychter.com>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz>  <m2d5cg1mwy.fsf@tnuctip.rychter.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 20:14:58 +1000
Message-Id: <1152353698.2555.11.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 11:11 +0200, Jan Rychter wrote:

> I hate these kinds of discussions, but since no one else did, I'm going
> to say this very openly: I don't think you should be the one "deciding"
> this.

ACK.

Given that:

- this tie is permanent due to fundamental design disagreements

- swsusp, uswsusp and Suspend2 can coexist in the same tree

- Nigel has a track record of excellent support for his code

Why not make another kernel subsystem (Suspend2) and make Nigel
maintainer of it? Then all this nonsense can stop and distributions and
users can pick what they really want.

Andrew? Linus?

-- 
Bojan

