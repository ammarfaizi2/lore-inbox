Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292514AbSBYX6g>; Mon, 25 Feb 2002 18:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292515AbSBYX60>; Mon, 25 Feb 2002 18:58:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20130 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292514AbSBYX6R>;
	Mon, 25 Feb 2002 18:58:17 -0500
Date: Mon, 25 Feb 2002 15:55:47 -0800 (PST)
Message-Id: <20020225.155547.55741458.davem@redhat.com>
To: hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <a5ehlm$1fe$1@cesium.transmeta.com>
In-Reply-To: <20020225230156.GA11786@merlin.emma.line.org>
	<20020225.150813.66161624.davem@redhat.com>
	<a5ehlm$1fe$1@cesium.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: 25 Feb 2002 15:34:14 -0800

   > This whole conversation exists because "Deleting the EXTRAVERSION
   > setting from linux/Makefile" then making new diffs/tars was screwed
   > up.  Doing it with a script isn't going to help this kind of problem.
   > 
   
   Sure it would.  It would make the likelihood for errors much lower.
   You need to make tarballs anyway.

Part of my suggestion involved putting up tarballs in the RC
releases, perhaps you missed that bit :-)
