Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTJBIlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 04:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJBIlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 04:41:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14996 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263276AbTJBIlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 04:41:15 -0400
Date: Thu, 2 Oct 2003 01:37:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test6][ROSE] timer cleanups (and couple of fixes)
Message-Id: <20031002013703.5072c707.davem@redhat.com>
In-Reply-To: <1065017300.7194.318.camel@lima.royalchallenge.com>
References: <1065017300.7194.318.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going to assume this one is not even minimally tested
either just like your X25 timer changes, and likewise I want
you to find a method to get the changes tested before I add
the changes to my tree.
