Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTIPN7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTIPN7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:59:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:9381 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261905AbTIPN7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:59:33 -0400
Subject: Re: [2.6 Patch] Kernel-doc updates 7 of 15 -- /fs/inode.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Still <mikal@stillhq.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <1063681483.3f667dcbbf875@dubai.stillhq.com>
References: <1063681483.3f667dcbbf875@dubai.stillhq.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063720681.10037.28.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Tue, 16 Sep 2003 14:58:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-16 at 04:04, Michael Still wrote:
>  
>  /*

Should be /** there for dispose_list so that the entry is generated,
otherwise it thinks its just a comment. The rest looks great


