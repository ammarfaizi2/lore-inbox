Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUBPPoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbUBPPoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:44:14 -0500
Received: from [212.28.208.94] ([212.28.208.94]:28677 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265742AbUBPPoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:44:11 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Eduard Bloch <edi@gmx.de>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Mon, 16 Feb 2004 16:44:08 +0100
User-Agent: KMail/1.6.1
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de>
In-Reply-To: <20040216140338.GA2927@zombie.inka.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402161644.08957.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 15.03, Eduard Bloch wrote:
> I know what you mean and that is why I already proposed a radical
> solution. Let me repeat it:
> 
>  - convert all files from the previous charset to UTF-8 overnight
>    if the previous charset was unknown, first make sure that you can
>    guess it for all users and contact users that have files with
>    suspicous filenames (eg. not convertable from Latin1). Or look trough
>    their shell/X config files (*)

Thankfully isolatin-1 (and all other encodings in use AFAIK) can be converted to UTF-8.
IsoLatin1 is also extremly simpe to convert-

-- robin
