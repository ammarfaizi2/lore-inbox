Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289374AbSA1UPg>; Mon, 28 Jan 2002 15:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSA1UP3>; Mon, 28 Jan 2002 15:15:29 -0500
Received: from peabody.ximian.com ([141.154.95.10]:14597 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S289375AbSA1UPD>; Mon, 28 Jan 2002 15:15:03 -0500
Subject: Re: Ethernet data corruption?
From: Kevin Breit <mrproper@ximian.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C55AE06.9C9AB33F@zip.com.au>
In-Reply-To: <1012250404.5401.6.camel@kbreit.lan> 
	<3C55AE06.9C9AB33F@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.23.19.37 (Preview Release)
Date: 28 Jan 2002 15:17:48 -0600
Message-Id: <1012252669.6159.16.camel@kbreit.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 14:01, Andrew Morton wrote:
> However, a number of ethernet cards do IP checksumming in
> hardware, so the kernel doesn't bother doing the checksum
> in software.
Interesting

> What ethernet card are you using?
I am using a built in (I think it's on the mobo actually) Intel
EtherExpress 10/100 Pro:

eepro100               17680   1

Thanks for the help

Kevin Breit

