Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWEWOfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWEWOfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWEWOfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:35:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36036 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932101AbWEWOfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:35:17 -0400
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herman Elfrink <herman.elfrink@ti-wmc.nl>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <44731733.7000204@ti-wmc.nl>
References: <44731733.7000204@ti-wmc.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 15:48:58 +0100
Message-Id: <1148395738.25255.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 16:07 +0200, Herman Elfrink wrote:
> FLAME uses an unofficial protocol number (0x4040), any tips on how to 
> get an official IANA number would be highly appreciated.
> 

Ethernet protocol number I assume you mean. If so this at least used to
be handled by the IEEE, along with ethernet mac address ranges.


