Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317735AbSGPClp>; Mon, 15 Jul 2002 22:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317743AbSGPClo>; Mon, 15 Jul 2002 22:41:44 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:21574 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S317735AbSGPClo>;
	Mon, 15 Jul 2002 22:41:44 -0400
From: <Hell.Surfers@cwctv.net>
To: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Date: Tue, 16 Jul 2002 03:44:16 +0100
Subject: RE:Re: Re: how to improve the throughput of linux network
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1026787456423"
Message-ID: <0fa130844021072DTVMAIL3@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1026787456423
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

well only if it was used little amounts, like once every hour, it would dynamically unload in between, and dont modules, recompile on each use? I was told they were, although im more of a sound driver person.

- "Yes. Yes. OKAY.", Installing Microsoft software has always felt like an argument with your Mum (alledgedly).

On Mon, 15 Jul 2002 22:36:52 -0400 (EDT) Mark Hahn <hahn@physics.mcmaster.ca> wrote:

--1026787456423
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from coffee.psychology.mcmaster.ca ([130.113.218.59]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Tue, 16 Jul 2002 03:30:22 +0100
Received: from localhost (hahn@localhost)
	by coffee.psychology.mcmaster.ca (8.11.6/8.11.6) with ESMTP id g6G2aqS25896
	for <Hell.Surfers@cwctv.net>; Mon, 15 Jul 2002 22:36:52 -0400
X-Authentication-Warning: coffee.psychology.mcmaster.ca: hahn owned process doing -bs
Date: Mon, 15 Jul 2002 22:36:52 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: <Hell.Surfers@cwctv.net>
Subject: RE:Re: Re: how to improve the throughput of linux network
In-Reply-To: <0f9412748011072DTVMAIL3@smtp.cwctv.net>
Message-ID: <Pine.LNX.4.33.0207152236400.25831-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: hahn@physics.mcmaster.ca

> Using it as a module would only slow you down if netfilter is required, because itwould load and unload, contstantly, causing you to remember what the 486 was like.

why would it get unloaded repeatedly?

--1026787456423--


