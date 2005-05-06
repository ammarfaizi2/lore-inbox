Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVEFMOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVEFMOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 08:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVEFMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 08:14:47 -0400
Received: from [213.170.72.194] ([213.170.72.194]:21734 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261180AbVEFMOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 08:14:45 -0400
Subject: Re: [PATCH] __wait_on_freeing_inode fix
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, dwmw2@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=KOI8-R
Organization: MTD
Date: Fri, 06 May 2005 16:14:39 +0400
Message-Id: <1115381679.27158.23.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Птн, 06/05/2005 в 13:46 +0200, Miklos Szeredi пишет:
> This patch fixes queer behavior in __wait_on_freeing_inode().
Although the patch looks sane & simple, I gonna test your patch today.
I'll report the results. 

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

