Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVCMTqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVCMTqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 14:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVCMTqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 14:46:14 -0500
Received: from mail.aknet.ru ([217.67.122.194]:50958 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261440AbVCMTqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 14:46:12 -0500
Message-ID: <42349891.70407@aknet.ru>
Date: Sun, 13 Mar 2005 22:46:25 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
References: <42348474.7040808@aknet.ru> <Pine.LNX.4.62.0503131950190.23588@alpha.polcom.net> <42349068.4030405@aknet.ru> <4234965C.1010502@rainbow-software.org>
In-Reply-To: <4234965C.1010502@rainbow-software.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Ondrej Zary wrote:
> I've just ran that on my Cyrix MII PR300 and the bug is present:<>
> UMC U5SX/33 in my router - also present:
Thanks, now I know for sure that it exist
everywhere.
Now you can apply the patch and make sure
the bug goes away:)

