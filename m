Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSDSKWM>; Fri, 19 Apr 2002 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSDSKWL>; Fri, 19 Apr 2002 06:22:11 -0400
Received: from violet.setuza.cz ([194.149.118.97]:5638 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S312169AbSDSKWK>;
	Fri, 19 Apr 2002 06:22:10 -0400
Subject: Re: /dev/zero
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <F10qwZ2cFXvmBUCsQrU0000e2b7@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Apr 2002 12:22:09 +0200
Message-Id: <1019211729.3619.9.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-04-19 at 10:33, blesson paul wrote:
> Hi
> 		I need some more information about /dev/zero. I need to replace the device 
> driver of /dev/zero(I do not know whether I can name the program controlling 
> the /dev/zero as device driver). How to do the job. If I cannot replace the 
> device driver of /dev/zero, how to create a new charecter device and load my 
> device driver.
> 
Hi,

I don't have any clue, why one should want to replace /dev/zero. But to
get a picture how to start writing a device driver, see
http://www.freeos.com/articles/2677/2/13/ ( Or
Goooooooooooooooooooooogle some other information ).

Regards
Frank

