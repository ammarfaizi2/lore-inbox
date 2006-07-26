Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWGZIj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWGZIj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWGZIj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:39:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030436AbWGZIj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:39:56 -0400
Date: Wed, 26 Jul 2006 01:39:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Drynoff <pauldrynoff@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] usb: device unconnect cause oops
Message-Id: <20060726013949.4eae206b.akpm@osdl.org>
In-Reply-To: <20060726122003.8f99cdea.pauldrynoff@gmail.com>
References: <20060726122003.8f99cdea.pauldrynoff@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006 12:20:03 +0400
Paul Drynoff <pauldrynoff@gmail.com> wrote:

> I used 2.6.18-rc1-mm2.
> 
> I have HP LaserJet 1010, it connected to computer via USB,
> I switched on it, printed something and swithched off it,
> after that I got in /var/log/messages:

Was
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/hot-fixes/drivers-base-check-errors-fix.patch
applied?
