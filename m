Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTJ0Tiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263521AbTJ0Tiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:38:52 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:57105 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S263522AbTJ0Tiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:38:51 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-testX and pppd/pppoe stuck after connecting
Date: Mon, 27 Oct 2003 21:56:23 +0300
User-Agent: KMail/1.5.3
Cc: Jan Ploski <jpljpl@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310272156.23961.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Andrew Borzenkov wrote:
>> I can confirm it with 2.6.0-test8 and simple modem connection (no
>> pppoe). Connection is established, I get IP, DNS - everything but no
>> IP packet ever seems to either go out or come in. The same works just
>> fine with 2.6.0-test5

whatever evil it was it has apparently disappeared in test9. Which may be good 
or bad news for you depending on whether your problem is fixed here as well.

good luck

-andrey

