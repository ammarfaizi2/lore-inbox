Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUBJItE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 03:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUBJItE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 03:49:04 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:26003 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S265776AbUBJItB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 03:49:01 -0500
From: johann lombardi <johann.lombardi@bull.net>
Reply-To: johann.lombardi@bull.net
Organization: BULL S.A.
To: Vojtech Pavlik <vojtech@suse.cz>,
       Murilo Pontes <murilo_pontes@yahoo.com.br>
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Date: Tue, 10 Feb 2004 08:33:34 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, wnelsonjr@comcast.net, ctpm@rnl.ist.utl.pt,
       clay@exavio.com.cn, mbuesch@freenet.de, mikeserv@bmts.com,
       gillb4@telusplanet.net, aeriksson@fastmail.fm
References: <200402041820.39742.wnelsonjr@comcast.net> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz>
In-Reply-To: <20040209004812.GA18512@ucw.cz>
MIME-Version: 1.0
Message-Id: <200402100833.34419.johann.lombardi@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/02/2004 08:36:43,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/02/2004 08:38:19,
	Serialize complete at 10/02/2004 08:38:19
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And here is a fix. Damn stupid mistake I made.
It solves the problem for me.
Thanks.

Johann

