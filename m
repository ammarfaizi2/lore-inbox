Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTL2HlR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 02:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTL2HlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 02:41:17 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:31713 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262792AbTL2HlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 02:41:16 -0500
Date: Mon, 29 Dec 2003 08:41:11 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Peter Leftwich <Hostmaster@Video2Video.Com>
Cc: debian-bsd@lists.debian.org, debian-user@lists.debian.org,
       owner-linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: mount from debian to 44bsd, chown bug report?
Message-ID: <20031229074111.GA24013@louise.pinerecords.com>
References: <20031228183005.G86605@rocket.alienwebshop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228183005.G86605@rocket.alienwebshop.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-28 2003, Sun, 18:43 -0500
Peter Leftwich <Hostmaster@Video2Video.Com> wrote:

>   # chown root /mnt/test
>   chown: changing ownership of `test': Read-only file system

Does dmesg reveal any clues as to why the fs is readonly?

-- 
Tomas Szepe <szepe@pinerecords.com>
