Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTKROpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbTKROpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:45:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:38069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262770AbTKROpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:45:02 -0500
X-Authenticated: #15936885
Message-ID: <3FBA3066.80508@gmx.net>
Date: Tue, 18 Nov 2003 15:44:54 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Brad House <brad@mcve.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Brad House <brad_mssw@gentoo.org>
Subject: Re: forcedeth: version 0.17 available
References: <3FB807A3.8010207@gmx.net> <3FB98C18.8090305@gmx.net> <3FB9A261.7080500@mcve.com>
In-Reply-To: <3FB9A261.7080500@mcve.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad House wrote:
> Well, the problem I saw was with the 2.6 patch.
> 
> These lines:
> 
> +++ build-2.6/drivers/net/forcedeth.c    2003-11-15 23:00:30.000000000
> +0100
> @@ -0,0 +1,1416 @@
> 
> Should be
> 
> +++ build-2.6/drivers/net/forcedeth.c    2003-11-15 23:00:30.000000000
> +0100
> @@ -0,0 +1,1418 @@

Aaah! The files were corrupted during upload. That's why I didn't find the
problem you described in my local version.
The problem is fixed now and MD5 sums have been uploaded to avoid this in
the future.

Thanks again,
Carl-Daniel


> Carl-Daniel Hailfinger wrote:
> 
>> Carl-Daniel Hailfinger wrote:
>>
>>> version 0.17 of forcedeth for Linux 2.4 and 2.6 is available at
>>> http://www.hailfinger.org/carldani/linux/patches/forcedeth/
>>
>>
>>
>> The patches for Linux 2.4 were malformed. Corrected versions have been
>> uploaded a few hours ago.
>> Thanks to Brad House for spotting this.

