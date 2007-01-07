Return-Path: <linux-kernel-owner+w=401wt.eu-S932566AbXAGOuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXAGOuJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbXAGOuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:50:09 -0500
Received: from chen.mtu.ru ([195.34.34.232]:1859 "EHLO chen.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932568AbXAGOuH (ORCPT <rfc822; linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:50:07 -0500
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 09:50:07 EST
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [announce] Squashfs 3.2 released
To: Arkadiusz Patyk <areq@areq.eu.org>, linux-kernel@vger.kernel.org,
       phillip@lougher.demon.co.uk
Date: Sun, 07 Jan 2007 17:39:04 +0300
References: <A1EA4789-E143-43C8-BBDC-0935EFA470A1@lougher.demon.co.uk> <c7r1q29p7qq1sjrb0n3fe3kn84roe1j40j@4ax.com>
User-Agent: KNode/0.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20070107143905.D7C5755634F@chen.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Patyk wrote:

> On Sun, 7 Jan 2007 05:33:53 +0000, you wrote:
> 
>>Hi,
>>
>>I'm pleased to announce the release of Squashfs 3.2.
> 
> What about lzma and squashfs ?
> 

I have patches for 3.0, 3.1 and (not yet finished) 3.2. As far as I can
tell:

src/squashfs3.2/squashfs-tools/lzma/README:
=======
This directory contains some source files from the
7z archive utility. (www.7-zip.org)

All the files in this directory was originally released
with the LGPL license.
=======

Now "originally released" is somewhat interesting form of expression, but I
do not think you can change license post factum.

The patches are for "personal use" but I am happy to work together to make
them ready for inclusion.

-andrey

