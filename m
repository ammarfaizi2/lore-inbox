Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUGGRKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUGGRKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 13:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUGGRKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 13:10:07 -0400
Received: from pop.gmx.net ([213.165.64.20]:12677 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265226AbUGGRKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 13:10:05 -0400
X-Authenticated: #4512188
Message-ID: <40EC2E6F.9060302@gmx.de>
Date: Wed, 07 Jul 2004 19:10:07 +0200
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: Re: 2.6.7-ck5
References: <40EC13C5.2000101@kolivas.org> <40EC2898.1090306@comcast.net>
In-Reply-To: <40EC2898.1090306@comcast.net>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> I'm on gentoo here, and just copied the ck2 ebuild to ck5, and it missed
> on a patch called ck-sources-2.6.IPTables-RDoS.  Any idea what this is,
> and is it already in?

I think it is already inside (look at Con's patch list). Just remove the 
line from the ebuild.

Prakash
