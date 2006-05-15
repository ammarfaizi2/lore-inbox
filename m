Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWEOVj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWEOVj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWEOVj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:39:57 -0400
Received: from web31508.mail.mud.yahoo.com ([68.142.198.137]:54443 "HELO
	web31508.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964862AbWEOVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:39:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l2b8k4CB53EP3ADpNKAo0MMhyjWi7o2Si63bfUj0uiWKK/S581zBsibjD6PnKMHeRcSG+ZGM1KDM95bv+MWrnCt7zY03OxHXwzNWhvorEYio/Q+XrMSTpypQftr4bwAsshhFaoHBcNzfeVyysYU+3Om5Mxv5bMjEZ74ol/Whf8w=  ;
Message-ID: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com>
Date: Mon, 15 May 2006 14:39:56 -0700 (PDT)
From: Jonathan Day <imipak@yahoo.com>
Subject: /dev/random on Linux
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For the three people who don't monitor the security
websites, there are claims that Linux' random number
generator has problems that could potentially be
exploited by an attacker to compromise encryption
algorithms, etc.

http://www.securiteam.com/unixfocus/5RP0E0AIKK.html

(Just because something is claimed does not make it
so, but it's usually worth checking.)

I know there have been patches around for ages to
improve the entropy of the random number generator,
but how active is work on this section of the code?


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
