Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVA1WW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVA1WW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVA1WW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:22:28 -0500
Received: from s2.home.ro ([193.231.236.41]:44214 "EHLO s2.home.ro")
	by vger.kernel.org with ESMTP id S262797AbVA1WWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:22:22 -0500
Subject: Re: kernel oops!
From: ierdnah <ierdnah@go.ro>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501281218020.2362@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
	 <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
	 <1106483340.21951.4.camel@ierdnac>
	 <Pine.LNX.4.58.0501230943020.4191@ppc970.osdl.org>
	 <1106866066.20523.3.camel@ierdnac>
	 <Pine.LNX.4.58.0501271532420.2362@ppc970.osdl.org>
	 <1106942401.27217.8.camel@ierdnac>
	 <Pine.LNX.4.58.0501281218020.2362@ppc970.osdl.org>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 00:22:45 +0200
Message-Id: <1106950965.15585.1.camel@ierdnac>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 12:28 -0800, Linus Torvalds wrote:


> I'm surprised that it makes _that_ much of a difference, but it sounds
> like you used to be borderline on CPU usage before, and this just made it
> much worse.

it's musch worst, I had a load of 5 with 250 VPN connections, and now, I
have a load of 200 with 150 connections

-- 
ierdnah <ierdnah@go.ro>

