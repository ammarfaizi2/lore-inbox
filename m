Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVCOTy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVCOTy6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVCOTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:52:12 -0500
Received: from mail.aknet.ru ([217.67.122.194]:16146 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261793AbVCOTs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:48:26 -0500
Message-ID: <42373C14.6010702@aknet.ru>
Date: Tue, 15 Mar 2005 22:48:36 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
References: <42348474.7040808@aknet.ru>	<20050313201020.GB8231@elf.ucw.cz>	<4234A8DD.9080305@aknet.ru>	<Pine.LNX.4.58.0503131306450.2822@ppc970.osdl.org>	<4234B96C.9080901@aknet.ru>	<20050314192943.GG18826@devserv.devel.redhat.com>	<4235ED35.1000405@aknet.ru> <20050314193447.47ca6754.akpm@osdl.org>
In-Reply-To: <20050314193447.47ca6754.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
> I added this patch to -mm.
Many thanks!

Alan, sorry for bothering you with that.


> - If the patch patches something which is in Linus's kernel, prepare a
>   diff against Linus's latest kernel.
> - If the patch patches something which is only in -mm, prepare a patch
>   against -mm.
> In this case, I merged the patch prior to the kgdb patch and then fixed
> up the fallout.
> (If that causes kgdb to break in non-obvious-to-me ways then I might come
> calling "help".
Thanks for explanations. That's what I
tried to find in your "The perfect patch"
guidelines many times, but it is not there
in such details.

