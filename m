Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVKZXPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVKZXPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 18:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVKZXPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 18:15:18 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:65400 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750782AbVKZXPR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 18:15:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KOkTz0Le8JstIYa2H71d/tWvABQtjzvBCJYWAG9XYUaa4dEFnoUHGWcuZ3pC7dzPzRncdTAbCZKejOllAEpQG/uwjDVHkhcsSxzn6fydcNRTNnI8LZey22X+l096cdS1AJFg6PRuo2FVApICHkb86sRkLGP2nO9NZcBcvsNBu7s=
Message-ID: <9c21eeae0511261515g28d63af3x76ad61c421380328@mail.gmail.com>
Date: Sat, 26 Nov 2005 15:15:16 -0800
From: David Brown <dmlb2000@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: mhf@users.berlios.de, linux-kernel@vger.kernel.org
In-Reply-To: <29495f1d0511261512x4ac3387ag3f9d9fe5360b19c2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511262319.15042.norbert-kernel@hipersonik.com>
	 <9c21eeae0511261427ld8375bfi1c838b56cab426fb@mail.gmail.com>
	 <20051126223921.E7EF31AC3@hornet.berlios.de>
	 <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com>
	 <29495f1d0511261512x4ac3387ag3f9d9fe5360b19c2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does using --no-same-permissions help when untarring?

yeah that worked.

- David Brown
