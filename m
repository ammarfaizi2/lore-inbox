Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTJGOx5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTJGOx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:53:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1992 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262395AbTJGOx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:53:56 -0400
Date: Tue, 7 Oct 2003 07:48:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
Cc: akpm@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test6][X25] timer cleanup
Message-Id: <20031007074833.6bb5a6e1.davem@redhat.com>
In-Reply-To: <1065362979.4370.34.camel@lima.royalchallenge.com>
References: <1065018387.7194.336.camel@lima.royalchallenge.com>
	<20031001155623.06b89258.akpm@osdl.org>
	<1065078208.4340.3.camel@lima.royalchallenge.com>
	<20031002013620.6d8b6f10.davem@redhat.com>
	<1065362979.4370.34.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Oct 2003 19:39:39 +0530
Vinay K Nallamothu <vinay.nallamothu@gsecone.com> wrote:

> On Thu, 2003-10-02 at 14:06, David S. Miller wrote:
> > Please find a way to at least minimally test the protocols
> > you are changing then, or find someone else who can.
>
> I have tested the patch using LAPB over Ethernet (I do not have real
> hardware) under linux-2.6.0-test5-uml1 and it works fine for me.

Fair enough, I've applied this patch, thanks a lot Vinay.
