Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUDMNTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 09:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbUDMNTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 09:19:52 -0400
Received: from [62.241.33.80] ([62.241.33.80]:8721 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263424AbUDMNTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 09:19:51 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.17 compilation error
Date: Tue, 13 Apr 2004 15:18:10 +0200
User-Agent: KMail/1.6.1
Cc: Ravi Kumar Munnangi <munnangi_ivar@yahoo.com>
References: <20040413131124.26121.qmail@web60608.mail.yahoo.com>
In-Reply-To: <20040413131124.26121.qmail@web60608.mail.yahoo.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404131518.10292@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 15:11, Ravi Kumar Munnangi wrote:

Hi Ravi,

>   I have RedHat Linux-8.0(2.4.18-14).
>   Now for some reasons I want to have 2.2.17 also.

may I ask why you want 2.2.17 and not 2.2.26?

>   But I faced the following errors after make bzImage
>   during compilation.
>   Iam sending the error in error.txt as attachment.
>   Please look into that and suggest me the correction.

Do RH8 has gcc3.x? If so, please install gcc 2.9x, because Kernel 2.2 can't be 
compiled with gcc 3.2.x/3.3.x

ciao, Marc
