Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270714AbUJUOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270714AbUJUOik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270723AbUJUOii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:38:38 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34524 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S270692AbUJUOgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:36:32 -0400
Subject: Re: [patch] 2.6.9-ac1: invalid SUBLEVEL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021124945.GD10801@stusta.de>
References: <1098356892.17052.18.camel@localhost.localdomain>
	 <20041021124945.GD10801@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098365506.17096.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 21 Oct 2004 14:31:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-21 at 13:49, Adrian Bunk wrote:
>  VERSION = 2
>  PATCHLEVEL = 6
> -SUBLEVEL = 9-ac1
> -EXTRAVERSION =
> +SUBLEVEL = 9
> +EXTRAVERSION = -ac1
>  NAME=AC 1

Doh I'm -amazed- that worked for me. Fixed in my tree, I'll go and hide
in a corner for a bit.

