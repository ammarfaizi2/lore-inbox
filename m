Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTH2ChY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 22:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbTH2ChY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 22:37:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:10177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264346AbTH2ChX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 22:37:23 -0400
Date: Thu, 28 Aug 2003 19:40:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: davidsen@tmr.com, cswingle@iarc.uaf.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
Message-Id: <20030828194039.7fabf13b.akpm@osdl.org>
In-Reply-To: <32865.4.4.25.4.1062124435.squirrel@www.osdl.org>
References: <20030828131019.69a9f3b9.akpm@osdl.org>
	<Pine.LNX.3.96.1030828220150.466A-100000@gatekeeper.tmr.com>
	<32865.4.4.25.4.1062124435.squirrel@www.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Is this the same issue as
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=106080170017645&w=2
>  in which AMD said, "Let us get back to you, ok?" on Aug. 13?

yes.
