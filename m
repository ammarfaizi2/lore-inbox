Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbSKJWoJ>; Sun, 10 Nov 2002 17:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265227AbSKJWoJ>; Sun, 10 Nov 2002 17:44:09 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:46990 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264975AbSKJWoI>; Sun, 10 Nov 2002 17:44:08 -0500
Date: Sun, 10 Nov 2002 23:50:43 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021110225043.GB9197@lina.inka.de>
References: <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> <E188MXo-00074b-00@sites.inka.de> <20021109201121.GA136@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021109201121.GA136@elf.ucw.cz>
User-Agent: Mutt/1.4i
From: Bernd Eckenfels <ecki@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 09:11:21PM +0100, Pavel Machek wrote:
> I do not think having md5 sum of /bin/ls helps so much -- what if I
> moify ld.so, instead?

the checksum is intended to mimic the exisiting priveledge revocatin on
altering. You could of course all all depenendn modules as checksums too,
but this would be more our current suid system supports.

Greetings
Bernd
