Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266165AbUAUWuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266166AbUAUWuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:50:44 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:57489
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266165AbUAUWul
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:50:41 -0500
Date: Wed, 21 Jan 2004 18:01:54 -0500
From: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to public posts
Message-ID: <20040121175954.A1343@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20040121213027.GN23765@srv-lnx2600.matchmail.com>; from Mike Fedyk on Wed, Jan 21, 2004 at 01:30:27PM -0800
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What do you think about individual email (non-list) using a confirmation
> based spam blocking system.

Consider a spammer using your address and spams people.  Say 25000 of those
use this method (Called challenge response authentication protocol).  You'll
get bombarded with 25000 challenge message.

You put the burden on the sender, not the spammer which is pretty much
useless.  There was a discussion about this on exim-users and someone posted
a web page.  http://kmself.home.netcom.com/Rants/challenge-response.html

> I currently use spamassassin to filter my messages, but I saw recently a
> project that asks you to reply to a confirmation message if you're not
> already on the white-list.
> 
> I'm not sure how acceptable it would be, and this is a little OT, but I'm
> wondering if I should spend the time testing that for my corp.

I for one refuse to answer those challenges unless I know it was due to a
spammer.  Defeats the purpose.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
