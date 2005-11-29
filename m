Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVK2VqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVK2VqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 16:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVK2VqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 16:46:12 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:11917 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932409AbVK2VqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 16:46:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc3
Date: Tue, 29 Nov 2005 22:47:08 +0100
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511292247.09243.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 29 of November 2005 05:11, Linus Torvalds wrote:
> 
> I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
> diffstats appended.

Hangs solid on boot on dual-core Athlon64.  No details yet, but I'm working
on them.  I wonder if anyone else is seeing this.

Greetings,
Rafael
