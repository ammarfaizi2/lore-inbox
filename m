Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319709AbSIMP6S>; Fri, 13 Sep 2002 11:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319710AbSIMP6S>; Fri, 13 Sep 2002 11:58:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319709AbSIMP6R>;
	Fri, 13 Sep 2002 11:58:17 -0400
Date: Fri, 13 Sep 2002 09:00:26 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <andy@chaos.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Extracting CONFIG_IKCONFIG data from 2.4.19-ac4
In-Reply-To: <slrnao3r8m.si3.abuse@madhouse.demon.co.uk>
Message-ID: <Pine.LNX.4.33L2.0209130859450.4465-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 2002, Andrew Bray wrote:

| I am using kernel 2.4.19-ac4 and I have been looking at using
| CONFIG_IKCONFIG to record the configuration in the kernel image.
|
| I have a question about this:
|
| There is a handy looking script in scripts/extract-ikconfig.  This
| uses a command called 'binoffset'.  I have never heard of this, can
| anyone point me to a source of binoffset, or an alternative to
| extract-ikconfig?

Yes, binoffset.c is here:
  http://www.osdl.org/archive/rddunlap/patches/

-- 
~Randy
"Linux is not a research project. Never was, never will be."
  -- Linus, 2002-09-02

