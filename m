Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVCKUVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVCKUVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVCKUU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:20:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:22673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261427AbVCKTZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:25:19 -0500
Date: Fri, 11 Mar 2005 11:21:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@graphe.net>
Cc: linux-kernel@vger.kernel.org, mark@chelsio.com, netdev@oss.sgi.com,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: A new 10GB Ethernet Driver by Chelsio Communications
Message-Id: <20050311112132.6a3a3b49.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503110356340.14213@server.graphe.net>
References: <Pine.LNX.4.58.0503110356340.14213@server.graphe.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@graphe.net> wrote:
>
> A Linux driver for the Chelsio 10Gb Ethernet Network Controller by
>  Chelsio (http://www.chelsio.com). This driver supports the Chelsio N210
>  NIC and is backward compatible with the Chelsio N110 model 10Gb NICs.

Thanks, Christoph.

The 400k patch was too large for the vger email server so I have uploaded it to

 http://www.zip.com.au/~akpm/linux/patches/stuff/a-new-10gb-ethernet-driver-by-chelsio-communications.patch

for reviewers.

> It supports AMD64, EM64T and x86 systems.

Is it only supported on those systems?  If so, why is that?

