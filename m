Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270651AbTGNQg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270636AbTGNQdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:33:33 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:1288 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270616AbTGNQc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:32:59 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [2.4 patch] Configure.help updates from -ac
Date: Mon, 14 Jul 2003 18:47:25 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
References: <200307141504.48728.m.c.p@wolk-project.de> <20030714162953.GN12104@fs.tum.de>
In-Reply-To: <20030714162953.GN12104@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141847.25101.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 18:29, Adrian Bunk wrote:

Hi Adrian,

> It's not me, this was directly taken from -ac.
yeah, ok.

> Please correct me if I'm wrong, but AFAIK these lines are used nowhere,
> they are just copies of the one-line descriptions in the Config.in
> files.
nope, you are right. But I think we should either leave all one-line 
descriptions from Config.in in or rip all out.

ciao, Marc

