Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTGAQAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTGAQAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:00:00 -0400
Received: from smtp1.xs4all.be ([195.144.64.135]:37809 "EHLO smtp1.xs4all.be")
	by vger.kernel.org with ESMTP id S262530AbTGAP77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:59:59 -0400
Date: Tue, 1 Jul 2003 18:13:51 +0200
From: Frank Gevaerts <frank@gevaerts.be>
To: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030701161351.GA24291@gevaerts.be>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Law11-F60taFcFzr8cg00039319@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law11-F60taFcFzr8cg00039319@hotmail.com>
User-Agent: Mutt/1.3.28i
X-flash-is-evil: do not use it
X-virus: If this mail contains a virus, feel free to send one back
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.8, required 5, AWL,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 12:04:37PM -0400, Matt Reuther wrote:
> It seems like the loopback device would be useful for this. You can move 
> all of you stuff into a mounted loopback device with the new fs. Is there 
> not some utility to take a filesystem image from inside an fs, and 
> overwrite that fs with it. It would be lots of sector-to-sector shuffling, 
> but it would be cleaner than trying to convert.

http://tzukanov.narod.ru/convertfs/ as someone (I don't remember who)
said earlier.

Frank

> Matt
