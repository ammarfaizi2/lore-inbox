Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSBDOGJ>; Mon, 4 Feb 2002 09:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288985AbSBDOGA>; Mon, 4 Feb 2002 09:06:00 -0500
Received: from [211.99.243.98] ([211.99.243.98]:51072 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288980AbSBDOFq>; Mon, 4 Feb 2002 09:05:46 -0500
Date: Mon, 4 Feb 2002 22:05:03 +0800
From: hugang <gang_hu@soul.com.cn>
To: Jens Axboe <axboe@suse.de>
Cc: andersen@codepoet.org, calin@ajvar.org, linux-kernel@vger.kernel.org
Subject: Re: Asynchronous CDROM Events in Userland
Message-Id: <20020204220503.6799df5b.gang_hu@soul.com.cn>
In-Reply-To: <20020204085712.O29553@suse.de>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
	<20020204070414.GA19268@codepoet.org>
	<20020204085712.O29553@suse.de>
Organization: soul
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__4_Feb_2002_22:05:03_+0800_08407c40"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__4_Feb_2002_22:05:03_+0800_08407c40
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit

Now it can work!
On Mon, 4 Feb 2002 08:57:12 +0100
Jens Axboe <axboe@suse.de> wrote:

> On Mon, Feb 04 2002, Erik Andersen wrote:
> > Jens Axboe and I wrote a little test app a year or two ago to check
> > for whether drives supported asynchronous mode.  We found it to be
> > unsupported on 100% of the drives we tested (and we tested quite a
> > few)...
> 
> Yep, _no_ drives to date support queued event notification. However, a
> polled approach is really not too bad -- it simply means that we'll push
> it to user space instead. I've written a small utility for reference.
> 
> -- 
> Jens Axboe
> 
> 


-- 
thanks with regards!
hugang.บ๚ธี.

***********************************
Beijing Soul Technology Co.,Ltd.
Tel:010-68425741/42/43/44
Fax:010-68425745
email:gang_hu@soul.com.cn
web:http://www.soul.com.cn
***********************************

--Multipart_Mon__4_Feb_2002_22:05:03_+0800_08407c40
Content-Type: application/octet-stream;
 name="diff"
Content-Disposition: attachment;
 filename="diff"
Content-Transfer-Encoding: base64

LS0tIGNkX3BvbGwuY34JTW9uIEZlYiAgNCAyMDoyNjoyNSAyMDAyCisrKyBjZF9wb2xsLmMJTW9u
IEZlYiAgNCAyMjowMzoyMSAyMDAyCkBAIC04MCw3ICs4MCw3IEBACiAJCXJldHVybiByZXQ7CiAJ
fQogCi0JcmV0dXJuIGJ1ZmZlcls0XSAmIDB4ZjsKKwlyZXR1cm4gYnVmZmVyWzVdICYgMHhmOwog
fQogCiBpbnQgcG9sbF9ldmVudHMoaW50IGZkKQo=

--Multipart_Mon__4_Feb_2002_22:05:03_+0800_08407c40--
