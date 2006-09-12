Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWILDc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWILDc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWILDc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:32:56 -0400
Received: from xenotime.net ([66.160.160.81]:18833 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964883AbWILDcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:32:55 -0400
Message-Id: <1158031971.5057@shark.he.net>
Date: Mon, 11 Sep 2006 20:32:51 -0700
From: "Randy Dunlap" <rdunlap@xenotime.net>
To: Victor Hugo <victor@vhugo.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] e-mail clients
X-Mailer: WebMail 1.25
X-IPAddress: 69.145.99.78
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> 
> As I've learned--most web-clients have a hard time sending text only 
> e-mail without
> wrapping every single line (not very good for patches).  Any 
suggestions 
> about which client to use on lkml?? Pine?? Mutt??
> Thunderbird?? Telnet??

pine (but make sure that it doesn't truncate trailing whitespace)
or mutt or sylpheed are all good.  tbird can be coerced into
working but it's not much fun (well, using attachments is easy,
but not good for people when reviewing/commenting on patches).

---
~Randy
