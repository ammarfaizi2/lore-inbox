Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbULZQYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbULZQYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbULZQYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:24:06 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:12930 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261693AbULZQYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:24:04 -0500
Date: Sun, 26 Dec 2004 16:24:26 +0000
From: Karel Kulhavy <clock@twibright.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to hang 2.6.9 using serial port and FB console
Message-ID: <20041226162426.GC5859@beton.cybernet.src>
References: <20041226143118.GA5169@beton.cybernet.src> <20041226145334.GC1668@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226145334.GC1668@gallifrey>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 02:53:35PM +0000, Dr. David Alan Gilbert wrote:
> Hi Karel,
>   I wonder - is the board sending a 'break' signal to the PC? I just
> remember years ago you could almsot lock machines up by constantly
> sending break.

But in this case the kernel doesn't care if you run it on a console without
a fancy background picture and hangs when you run it on a fancy background
picture.

The picture is what seems to be evil here.

Cl<
