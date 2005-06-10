Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVFJMBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFJMBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 08:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVFJMBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 08:01:55 -0400
Received: from mail.velocity.net ([66.211.211.55]:56973 "EHLO
	mail.velocity.net") by vger.kernel.org with ESMTP id S261374AbVFJMBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 08:01:54 -0400
X-AV-Checked: Fri Jun 10 08:01:54 2005 clean
Subject: Re: 2.6.11(.7-11) sync_page problem
From: Dale Blount <linux-kernel@dale.us>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1118081146.12388.32.camel@dale.velocity.net>
References: <1118081146.12388.32.camel@dale.velocity.net>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 08:01:53 -0400
Message-Id: <1118404913.1753.2.camel@dale.velocity.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The server also has various clients from 2.4.23 to 2.6.11.11 which all
> seem to behave fine (however their workloads are different).  I've
> noticed this happen with almost no load, to multiple occurrences with a
> load of ~4.0 or so.


FWIW, I've switched the problematic client back to 2.6.10 and it seems
to be completely stable again.

Dale

