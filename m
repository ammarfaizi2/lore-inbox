Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVGFULl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVGFULl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVGFULG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:11:06 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:23705 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262358AbVGFTeT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:34:19 -0400
Date: Wed, 6 Jul 2005 12:34:15 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?TWljaGFfXw==?= Piotrowski 
	<piotrowskim@trex.wsi.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2 white spaces patch
Message-Id: <20050706123415.19a33a8a.rdunlap@xenotime.net>
In-Reply-To: <42CC30C2.5030300@trex.wsi.edu.pl>
References: <42CBDF6D.8090802@trex.wsi.edu.pl>
	<20050706120957.1a88b46f.rdunlap@xenotime.net>
	<42CC30C2.5030300@trex.wsi.edu.pl>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jul 2005 21:28:02 +0200 Micha__ Piotrowski wrote:

| Hi Randy,
| 
| randy_dunlap napisa__(a):
| 
| >On Wed, 06 Jul 2005 15:41:01 +0200 Micha__ Piotrowski wrote:
| >
| >| Hi,
| >| 
| >| This patch is against 2.6.13-rc2. It cleans whitespaces in init/* and 
| >| crypto/*.
| >
| >General comment:  needs a Signed-off-by: line (see
| >Documenation/SubmittingPatches ).
| >
| >Howver, I am having trouble seeing changes in lots of the
| >-/+ lines.  Did thunderbird perhaps mangle your patch?
| >
| >After that is fixed, we can see if it's worthwhile to do this
| >kind of patch....  (some doubt here)
| >
| >

| >---
| >~Randy
| >
| >  
| >
| Ups,
| 
| I resend the patrch, because iso-8859-2 coding in thunderbird is f%##**%%#.
| Patch is in atachment ;) (bz'iped).

OK, I can see the whitespace changes now, but please don't send patches
in any kind of zip format, it makes them impossible for someone to review
and comment on them.  Attachments are allowed (or tolerated) if they
are of type text/plain so that an email client can display them
inline with the rest of the mail message.

---
~Randy
