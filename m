Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVBLVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVBLVPr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 16:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVBLVPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 16:15:46 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:3132 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261151AbVBLVPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 16:15:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hnqz/nZf50+C0E3FofEf6j73daX9xA0zOrNk0I7gzctf9ViXWKvP+lACXnoQOlVDoaMH9futco+nybKIZf8azUeq6hI3aTmUtHTc24JbJb21nvzRPujFCmFfYwlPr+rFQyMh8Igayzyri5VLtcIsuuQu2FptG4SIRaWRYmyf/Dw=
Message-ID: <f396da08050212131558581168@mail.gmail.com>
Date: Sat, 12 Feb 2005 23:15:40 +0200
From: Margus Eha <margus.eha@gmail.com>
Reply-To: Margus Eha <margus.eha@gmail.com>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: bttv: tuner: i2c i/o error: rc == -121 (should be 4)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <culodt$u8s$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f396da08050212112363a4b5cf@mail.gmail.com>
	 <culodt$u8s$2@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the notification.

Margus


On Sat, 12 Feb 2005 21:22:17 +0100, Jindrich Makovicka
<makovick@kmlinux.fjfi.cvut.cz> wrote:
> Margus Eha wrote:
> > Tv card works but i can't change channel. Something goes wrong in tuner.c
> > when tvtime program tries to change frequency. In /var/log/messages i can find
> > tuner: i2c i/o error: rc == -121 (should be 4).
> >
> > Las working version i tried was 2.6.11-rc2
> > Both 2.6.11-rc3-mm1 and Both 2.6.11-rc3-mm2 are not working.
> >
> > If kernel conf is needed i can send.
> 
> http://bugme.osdl.org/show_bug.cgi?id=4171
> 
> --
> JM
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
