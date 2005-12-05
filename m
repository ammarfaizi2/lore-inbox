Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbVLFAXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbVLFAXe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbVLFAXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:23:34 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:64685 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751514AbVLFAXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:23:33 -0500
Message-ID: <045801c5f9fa$8f0a14f0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs> <1133481721.9597.37.camel@lade.trondhjem.org> <00e501c5f809$99c70bc0$0400a8c0@dcccs> <1133622663.7911.5.camel@lade.trondhjem.org> <011201c5f8e1$557c32a0$0400a8c0@dcccs> <1133708033.8016.16.camel@lade.trondhjem.org>
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
Date: Tue, 6 Dec 2005 00:14:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> OK. There is one more patch that I fed into 2.6.15-rc5 and that might
> help. Either grab 2.6.15-rc5 from kernel.org, og grab it from
>
>
http://client.linux-nfs.org/Linux-2.6.x/2.6.15-rc4/linux-2.6.15-05-fix_attr_updates.dif

Yes, this patch solved the problem. :-)

Thanks,
Janos

>
> Cheers,
>  Trond
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

