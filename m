Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUBXErK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUBXErJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:47:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:9900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262159AbUBXErH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:47:07 -0500
Date: Mon, 23 Feb 2004 20:52:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI update for 2.6.3
In-Reply-To: <1077596668.1983.282.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0402232051500.3005@ppc970.osdl.org>
References: <1077596668.1983.282.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Feb 2004, James Bottomley wrote:
>
> Kai Mäkisara:
>   o Sysfs class support for SCSI tapes

Has this been checked for correctness, or will Al flame me to a crisp for 
accepting it? Pls verify..

		Linus
