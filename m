Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUJAUk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUJAUk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUJAUju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:39:50 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:56000 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266488AbUJAUdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:33:09 -0400
Message-ID: <f8ca0a1504100113335eca90bb@mail.gmail.com>
Date: Fri, 1 Oct 2004 13:33:04 -0700
From: Roland Dreier <roland.list@gmail.com>
Reply-To: Roland Dreier <roland.list@gmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: Hard lockup on IBM ThinkPad T42
Cc: Martin Hermanowski <martin@mh57.de>, linux-thinkpad@linux-thinkpad.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <f8ca0a150409301812f2da74d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f8ca0a1504093011206230ddea@mail.gmail.com>
	 <20040930205851.GA6911@mh57.de>
	 <f8ca0a1504093014456cf072a1@mail.gmail.com>
	 <20040930222712.GB4607@marowsky-bree.de>
	 <f8ca0a150409301812f2da74d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night I upgraded the ipw2200 driver from 0.9 to 0.11, and since
then I haven't had any lockups (13 hours of uptime -- pretty pathetic
in the Linux scheme of things but much better than what I was getting
before).

 - Roland
