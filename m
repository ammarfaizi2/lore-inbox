Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUBXUXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbUBXUXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:23:46 -0500
Received: from intra.cyclades.com ([64.186.161.6]:60055 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262436AbUBXUXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:23:44 -0500
Date: Tue, 24 Feb 2004 18:16:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Sid Stautzenberger <sstautzenberger@htshq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels 2.4.21 and Subsequent and Toshiba XM-1702B CDROMs
In-Reply-To: <001901c3f7f1$051a6220$10a8a8c0@htshq.com>
Message-ID: <Pine.LNX.4.58L.0402241816190.23951@logos.cnet>
References: <001901c3f7f1$051a6220$10a8a8c0@htshq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Sid Stautzenberger wrote:

> Linux-Kernel.Org:
>
> I'm not sure where to ask help for this problem. I have installed and tested
> many Linux distros on my Dell Inspiron 3200 which uses a Toshiba XM-1702B
> CDROM. I have had no problem with installing any distro from CD iso images.
> Now I have discovered that all distros built on kernels 2.4.21 or subsequent
> no longer support the Toshiba XM-1702B drive. I've tried reading thru the
> kernel source programs and information, and it leads one to believe that
> this CDROM is still supported. This can't be the case. Who can I ask for
> help getting a fix. I am presently using Slackware based on 2.4.20 and
> Xandros based on 2.4.19.
> Ditributions based on 2.4.21/22/24 and 2.6.1/2 will attempt to read the
> CDROM (/dev/hdc) but after nearly a minute an error will be displayed
> indicating dirctory not found. I think the problem is in the ide code in the
> kernel source. Exactly where I haven't a clue. I'm stuck not being able to
> upgrade to newer kernels.

Hi Sid,

What are the error messages from both 2.4 and 2.6 ?

