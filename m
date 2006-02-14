Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWBNEGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWBNEGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWBNEGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:06:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54943 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030335AbWBNEGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:06:16 -0500
Date: Mon, 13 Feb 2006 20:05:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Nikolay N. Ivanov" <nn@nndl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.x - very slow disk-writing
Message-Id: <20060213200517.20f7a291.akpm@osdl.org>
In-Reply-To: <43F0F67A.8080001@nndl.org>
References: <43F0F67A.8080001@nndl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nikolay N. Ivanov" <nn@nndl.org> wrote:
>
> Disk-writing in 2.6.15.[1, 2, 3, 4] is very slowly on my computer. There 
>  is no such problem in 2.6.[10, 11, 12, 13, 14] with even configuration.
> 
>  PC PIII, IDE HDD, 512RAM, Fs-type: ext3, swap partition: 512MB, 
>  Slackware 10.1
> 
>  I tryed to install 2.6.15.x on other computer with other 
>  Linux-distribution (Mandriva) and the error stays.

Please send the output of `dmesg -s 1000000'.
