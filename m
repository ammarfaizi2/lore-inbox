Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVLENzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVLENzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVLENzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:55:42 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:9945 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S932403AbVLENzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:55:42 -0500
X-ME-UUID: 20051205135538229.37FE21FF97C3@mwinf0102.wanadoo.fr
Subject: Re: Linux in a binary world... a doomsday scenario
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dave Airlie <airlied@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970512050339s392c12a9jd4168cd707bb5e8d@mail.gmail.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <21d7e9970512050339s392c12a9jd4168cd707bb5e8d@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133790928.1615.80.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 05 Dec 2005 14:55:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 12:39, Dave Airlie wrote:
> This is pretty much how the 3D drivers has gone down

.. and it doesn't look like the Xorg people are willing/able to do
something against that: witness the current thread named "Official
method for determining modular X module path?" on Xorg's mailing-list
which deals *exactely* with Arjan's theoretical problems of
cross-distributions modules compatibility, with the same pragmatism that
made Linus choose Bitkeeper. 
As one can consider Xorg as being a device driver, albeit in userspace,
you see that the 3D part isn't going up any time soon.


