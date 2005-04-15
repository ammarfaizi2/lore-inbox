Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVDOGuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVDOGuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 02:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVDOGuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 02:50:51 -0400
Received: from mail1.kontent.de ([81.88.34.36]:35565 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261749AbVDOGur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 02:50:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [OOPS] on usb removal, and minicom closing 2.6.11.7
Date: Fri, 15 Apr 2005 08:51:51 +0200
User-Agent: KMail/1.7.1
Cc: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>,
       JustMan <justman@e1.bmstu.ru>, linux-kernel@vger.kernel.org
References: <425E5682.6060606@pointblue.com.pl> <425E64C4.5020704@pointblue.com.pl> <20050414230621.49663f75.vsu@altlinux.ru>
In-Reply-To: <20050414230621.49663f75.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504150851.52338.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The patches which really seem to fix the underlying problem can be found
> in this thread:
> 
> http://thread.gmane.org/gmane.linux.usb.devel/32977
> 
> (see "[PATCH] N/3 cdc acm errors").
> 
> You also need this driver core fix:
> 
> http://thread.gmane.org/gmane.linux.usb.devel/33132

Has the fix been applied?

	Regards
		Oliver
