Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSKMPyc>; Wed, 13 Nov 2002 10:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSKMPyc>; Wed, 13 Nov 2002 10:54:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5272 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262210AbSKMPyb>;
	Wed, 13 Nov 2002 10:54:31 -0500
Date: Wed, 13 Nov 2002 07:55:50 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Margit Schubert-While <margit@margit.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.47-ac2
In-Reply-To: <4.3.2.7.2.20021113091351.00b51c90@mail.dns-host.com>
Message-ID: <Pine.LNX.4.33L2.0211130752090.31388-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Margit Schubert-While wrote:

| To keep you all busy :-)

so you don't actually need all of these working for you?

| make[2]: *** [drivers/block/DAC960.o] Error 1

If DAC960 is important to you, please try the patches at
  http://www.osdl.org/archive/dmo/


| make[3]: *** [drivers/message/i2o/i2o_lan.o] Error 1
Alan has already commented on i2o_lan.

-- 
~Randy
  "I read part of it all the way through." -- Samuel Goldwyn

