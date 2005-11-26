Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVKZV6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVKZV6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 16:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKZV6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 16:58:35 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:48823 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750758AbVKZV6e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 16:58:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K4ot17p8a7YWnIhnv4oCEW5jwsG59o8r08SH7VHiRU+SD+Cz5/Nvft8Ql8Z+qcz8zQknEcSDqOoCTUuNsijWepQBy3cvE7aZ30rRQF3TC0CM8YRPHoqIlT5mHZrvQ96twtaoHVvKmOvBee6Q8T/ONFkRWA31PZGDJf3+LgDTmgA=
Message-ID: <9c21eeae0511261358v723419f2g853bddc839038996@mail.gmail.com>
Date: Sat, 26 Nov 2005 13:58:31 -0800
From: David Brown <dmlb2000@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.14.tar.bz2 permissions
In-Reply-To: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't sure where to send this but here goes.

 Seems that many of the source files in the linux-2.6.14.tar.bz2 have
global read/write permissions.
 Are the permissions supposed to be this way now?
 If not, could this be fixed soon?
 if so, could you point me to a url that explains why.

 - David Brown
