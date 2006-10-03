Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWJCQkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWJCQkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWJCQkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:40:52 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:38159 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S932261AbWJCQkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:40:51 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Spam, bogofilter, etc
Date: Tue, 3 Oct 2006 18:42:35 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <1159539793.7086.91.camel@mindpipe> <20061002100302.GS16047@mea-ext.zmailer.org>
In-Reply-To: <20061002100302.GS16047@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031842.35636.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

> Yes, the thing is NOT 100% perfect.
> Especially very short spams are prone to leak thru it,
> and those hams that do get block do tend to be longish, and
> never before seen.  (It all comes from Bayes Statistics.)

If I can suggest something. Please run latest p0f and match the output against 
vger incoming traffic (or even only against the messages that leak trough the 
filters used now). I bet you'll see an obvious and very descriptive pattern. 
Now what you will or will not do with that knowledge is the other story.

	Mariusz
