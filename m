Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRKKXgT>; Sun, 11 Nov 2001 18:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281168AbRKKXgJ>; Sun, 11 Nov 2001 18:36:09 -0500
Received: from AGrenoble-101-1-2-175.abo.wanadoo.fr ([193.253.227.175]:53376
	"EHLO strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281160AbRKKXfv>; Sun, 11 Nov 2001 18:35:51 -0500
Message-ID: <3BEF0BE7.3010603@wanadoo.fr>
Date: Mon, 12 Nov 2001 00:38:15 +0100
From: =?ISO-2022-JP?B?RnJhbmMsb2lz?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: abusch@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oops] 2.4.14 ipchains/netfilter or scsi/usb ? modprobe on boot
In-Reply-To: <3BEF0419.BCD63716@gmx.net>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Busch wrote:

> When the system is up I also get an unresolved symbol "deactivate_page"
> for loading the
> "loop" device driver.  


_known_ bug
patch is in 2.4.14pre1/pre2/pre3
warning, 2.4.14pre1/pre2 do not work with iptables, whereas pre3 does.

Franc,ois





