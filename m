Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUBDLkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 06:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266343AbUBDLiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 06:38:46 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:60326 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266340AbUBDLhh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 06:37:37 -0500
Subject: Re: delete file function!
From: Vladimir Saveliev <vs@namesys.com>
To: Alexandr Chernyy <nikalex@hotbox.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4020D667.7070708@hotbox.ru>
References: <4020D667.7070708@hotbox.ru>
Content-Type: text/plain
Message-Id: <1075894655.1829.125.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 04 Feb 2004 14:37:35 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 14:24, Alexandr Chernyy wrote:
> Hello All! I have some question! Where in kernel files i can find a 
> deleting file  function ???
> 
linux/fs/inode.c:generic_delete_inode()

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

