Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTBYOdL>; Tue, 25 Feb 2003 09:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267070AbTBYOdL>; Tue, 25 Feb 2003 09:33:11 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:28090 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S267033AbTBYOdK>; Tue, 25 Feb 2003 09:33:10 -0500
Date: Tue, 25 Feb 2003 15:43:24 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/net/dev with tg3 and 2.4.19
Message-ID: <20030225154324.A923@pc9391.uni-regensburg.de>
References: <20030225113429.C1866@pc9391.uni-regensburg.de> <3E5B80AC.2010905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3E5B80AC.2010905@pobox.com>; from jgarzik@pobox.com on Tue, Feb 25, 2003 at 15:41:48 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.2003   15:41 Jeff Garzik wrote:
> Christian Guggenberger wrote:
>> Hi,
>> 
>> With tg3 from 2.4.19 the Recieve/Transmit-bytes entries grow to 4294967295, 
>> but then stay at this value. This isn't the expected behaviour, is it? All 
>> other net drivers will jump back to zero and count up again, won't they?
>> Is there a patch available?
>> Otherwise 2.4.19's tg3 seems pretty stable to me, as it's running since 
>> 2002 Oct. 7th with no problems...
> 
> 
> That's fixed in later versions...
> 
where can I get later versions for 2.4.19?

Christian
