Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVKZWli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVKZWli (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVKZWli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 17:41:38 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:3508 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750770AbVKZWlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 17:41:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FLTsQ0Qy+Yd0Y4bAHQHX2lq0KCxZrnXRon5tMlPuxW6x48ACe2pT1038Vhr7OVi2d13CgcX73XMAMZj3HP+ju7u3nViyobnpPKddYdF38gzf+bLIKoGUn3Fwxiktsg4jvuqPdHqrC/+NE7IxHb34Zc5r0I+SyddrLdsiUSx0W34=
Message-ID: <9c21eeae0511261441j7e4cc7c7ya99daaf1e437cb2a@mail.gmail.com>
Date: Sat, 26 Nov 2005 14:41:35 -0800
From: David Brown <dmlb2000@gmail.com>
To: mhf@users.berlios.de
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051126223921.E7EF31AC3@hornet.berlios.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511262319.15042.norbert-kernel@hipersonik.com>
	 <9c21eeae0511261427ld8375bfi1c838b56cab426fb@mail.gmail.com>
	 <20051126223921.E7EF31AC3@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Check your umask and set it to 022 ;)

it is, still comes up world read/write.

- David Brown
