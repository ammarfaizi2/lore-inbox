Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbTL3NgO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 08:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbTL3NgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 08:36:14 -0500
Received: from mail.aei.ca ([206.123.6.14]:19400 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S265789AbTL3NgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 08:36:13 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 - Watchdog patches (BK consistency checks)
Date: Tue, 30 Dec 2003 08:36:15 -0500
User-Agent: KMail/1.5.93
References: <20030906125136.A9266@infomag.infomag.iguana.be> <Pine.LNX.4.58.0312291226400.2113@home.osdl.org> <20031230004907.GA29143@merlin.emma.line.org>
In-Reply-To: <20031230004907.GA29143@merlin.emma.line.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312300836.16559.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 29, 2003 07:49 pm, Matthias Andree wrote:
> Well, talk about FAAAAAAST drives (10,025/min SCSI kind) unless you have
> time to waste on all those BK consistency checks (which are, of course,
> what #3 is all about).
>
> Or am I missing some obvious short cut?

Is there a way to tell BK when to do consistency checks?  Here they easily take
15-20 min each time.  I would love to be able to tell BK to defer these checks.

Ed Tomlinson
