Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbWB1XQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWB1XQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWB1XQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:16:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932712AbWB1XQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:16:54 -0500
Date: Tue, 28 Feb 2006 15:15:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228151544.019aa2b4.akpm@osdl.org>
In-Reply-To: <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
>  Since I'm in X when the lockup happens and I don't have enough time
>  from clicking the eclipse icon to the box locks up to make a switch to
>  a text console I don't know if an Oops or similar is dumped to the
>  console (there's nothing in the locks after a reboot)  :-(

In a shell, do

	sleep 10 ; /path-to-eclipse


