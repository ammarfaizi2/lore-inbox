Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbTFHJAo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 05:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTFHJAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 05:00:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8075 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261216AbTFHJAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 05:00:44 -0400
Date: Sun, 08 Jun 2003 02:11:29 -0700 (PDT)
Message-Id: <20030608.021129.115917085.davem@redhat.com>
To: acme@conectiva.com.br
Cc: azarah@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] compile fixes for recent changes to
 include/net/sock.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030607210338.GE10340@conectiva.com.br>
References: <1055007025.6805.19.camel@nosferatu.lan>
	<20030607210338.GE10340@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sat, 7 Jun 2003 18:03:38 -0300
   
   Question: it is marked as OBSOLETE, should we ditch it now?

Unfortunately I have no idea how widely used ethertap is these
days, and more importantly if most people have switched over
to tun/tap for those kinds of applications.
