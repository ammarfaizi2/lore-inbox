Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTJaVIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTJaVIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 16:08:46 -0500
Received: from rth.ninka.net ([216.101.162.244]:9632 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263574AbTJaVIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 16:08:45 -0500
Date: Fri, 31 Oct 2003 13:08:33 -0800
From: "David S. Miller" <davem@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: tytso@mit.edu, andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
Message-Id: <20031031130833.42788aec.davem@redhat.com>
In-Reply-To: <3FA2CA5E.3050308@namesys.com>
References: <3F9F7F66.9060008@namesys.com>
	<20031029224230.GA32463@codepoet.org>
	<20031030015212.GD8689@thunk.org>
	<3FA0C631.6030905@namesys.com>
	<20031030174809.GA10209@thunk.org>
	<3FA16545.6070704@namesys.com>
	<20031030203146.GA10653@thunk.org>
	<3FA211D3.2020008@namesys.com>
	<20031031193016.GA1546@thunk.org>
	<3FA2CA5E.3050308@namesys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003 23:47:26 +0300
Hans Reiser <reiser@namesys.com> wrote:

> If you say that names resolve to single objects and never should 
> resolve to sets of objects, we disagree.

While I have no personal opinion either way on the utility of such an
idea, I do think that if we ever do support a "one to many" mapping of
names to inodes we should make you do the security audit of a full
Linux system in the presence of this feature, deal?  :-)
