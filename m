Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTDDN6F (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTDDNxS (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:53:18 -0500
Received: from mail.set-software.de ([193.218.212.121]:39101 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP id S263627AbTDDNuc convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 08:50:32 -0500
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Fri, 04 Apr 2003 14:00:44 GMT
Message-ID: <20030404.14004462@knigge.local.net>
Subject: Re: Strange e1000
To: "Paul Rolland" <rol@as2917.net>
CC: <linux-kernel@vger.kernel.org>
In-Reply-To: <043501c2faaf$da061e10$3f00a8c0@witbe>
References: <043501c2faaf$da061e10$3f00a8c0@witbe>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Could it be possible that the 1000MBps FD on the e1000 side is
> a local configuration, and that it needs some time to discuss with
> the Netgear switch to negotiate correctly speed and duplex before
> working correctly ? (i.e. 20 sec = negotiation time)

Hmmm, I don't think so but I will try to 

A) force e1000 to negotiate only 1000/FD   and
B) configure the switch to force 1000/FD

Maybee it wil help....


Bye
  Michael




