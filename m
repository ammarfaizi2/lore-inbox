Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTEDVOk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTEDVOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:14:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63195 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261769AbTEDVOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:14:34 -0400
Date: Sun, 04 May 2003 13:19:51 -0700 (PDT)
Message-Id: <20030504.131951.26530132.davem@redhat.com>
To: acme@conectiva.com.br
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list.h: implement list_for_each_entry_safe
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030504212438.GA14414@conectiva.com.br>
References: <20030504075748.GD12549@conectiva.com.br>
	<1052052632.27465.0.camel@rth.ninka.net>
	<20030504212438.GA14414@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sun, 4 May 2003 18:24:38 -0300

   Em Sun, May 04, 2003 at 05:50:32AM -0700, David S. Miller escreveu:
   > On Sun, 2003-05-04 at 00:57, Arnaldo Carvalho de Melo wrote:
   > > ChangeSet@1.1219, 2003-05-04 04:39:21-03:00, acme@conectiva.com.br
   > >   o list.h: implement list_for_each_entry_safe
   > 
   > Exists already, there is even a _rcu version.
   
   Huh? Where is that? :-)
   
I misread your email, sorry.  Your patch is ok.
