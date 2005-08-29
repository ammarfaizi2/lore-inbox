Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVH2CeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVH2CeO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 22:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVH2CeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 22:34:14 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:19108 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbVH2CeO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 22:34:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZlVi7GpMN6aG1zuZ3nSZtPXOaCRnzBA/TvPWmnjepMx7rXACRbPrfBny9Hop2BNHbPFjZeguMrs5Qde/zFVREBdTOX0AXXRJSPUbVDpVpiy9TNqx7wTvtVvbXnaWuzPmg/2/rU6G6goFwp4D83X+HLsMcUv+OkBfqqUBfuckRks=
Message-ID: <88ee31b705082819341961949e@mail.gmail.com>
Date: Mon, 29 Aug 2005 11:34:09 +0900
From: Jerome Pinot <ngc891@gmail.com>
To: jesper.juhl@gmail.com
Subject: Re: Linux 2.6.13
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On 8/29/05, Linus Torvalds <...> wrote:
>> 
>> There it is.
>> 
>http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.13 seems to
>be the 2.6.13-rc7 -> 2.6.13 final ChangeLog. Any chance we could get
>the full 2.6.12 -> 2.6.13 ChangeLog up there?

Using git in the linus tree:
$ git-whatchanged v2.6.12..v2.6.13 --pretty=full

You can get this:

ftp://ngc891.blogdns.net/pub/linux/misc/ChangeLog-2.6.12-2.6.13.txt 

Be warn, it's about 3.7MB

-- 
Jerome Pinot
ftp://ngc891.blogdns.net/pub
