Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbTAIApP>; Wed, 8 Jan 2003 19:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267728AbTAIApO>; Wed, 8 Jan 2003 19:45:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:12740 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267727AbTAIApO>;
	Wed, 8 Jan 2003 19:45:14 -0500
Date: Wed, 8 Jan 2003 16:50:20 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "studio3arc.com Admin" <admin@studio3arc.com>
cc: <henrique.gobbi@cyclades.com>, <linux-kernel@vger.kernel.org>
Subject: RE: modutils x 2.5.54
In-Reply-To: <001601c2b779$2748bf40$6601a8c0@s3ac>
Message-ID: <Pine.LNX.4.33L2.0301081649500.6873-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, studio3arc.com Admin wrote:

| ect: Re: modutils x 2.5.54
| >
| >
| > On Wed, 8 Jan 2003, Henrique Gobbi wrote:
| >
| > | Hi all !!!
| > |
| > | Which version of modutils am I suppose to use with the
| > kernel 2.5.54
| > | ??? Where can I find it ???
|
| Is there a way to tell if your compile was successful like a ****
| --version command ?

modprobe --version
gives me 0.9.5.

lsmod and insmod don't support --version.

-- 
~Randy

