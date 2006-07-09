Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161205AbWGIWe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbWGIWe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbWGIWe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:34:28 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:11364 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161205AbWGIWe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:34:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4RcpqDjBK+o7a9FO61XXu4RzvjzGAuxS1Z7KvzvARm27NoA2zGZxdYo08B2+cWGmJxtcxOFux9QswbcWbdYtnHaqY2YmJtr82aPk8/r+hrzFdZxTWGwtP/epoxBmXDMl/mkkb/3L9GRI4PCcGyeUqozApL2JDmmu2ban666gB0=
Message-ID: <f44c5fdf0607091534v703f6e2ay406dec902aa4f95a@mail.gmail.com>
Date: Mon, 10 Jul 2006 00:34:26 +0200
From: "=?UTF-8?Q?Rados=C5=82aw_Szkodzi=C5=84ski?=" <astralstorm@gmail.com>
To: PrXenoN <prx@cinatas.ath.cx>
Subject: Re: [2.6.17-mm3] reiser4 breakage
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151555221.7088.9.camel@prxenon>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151555221.7088.9.camel@prxenon>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/6/29, PrXenoN <prx@cinatas.ath.cx>:
> Hi,
>
> for me reiser4 seems broken since 2.6.17-mm3. During bootup of the
> system i reach the initscripts, but then complains about FS problems. I
> did fsck.reiser4 and even rebuild my fs with it (as was suggested by the
> tool). Some errors were found and fixed, but i still cannot bring the
> system up.

It's been broken since 2.6.17-mm2 at least. Similar message, small
damage to the filesystem (only /var).

2.6.17-mm1 is okay here.
