Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVEESI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVEESI3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVEESI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:08:29 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:30019 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262167AbVEESIX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:08:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fV2MA3o7HCTN9kk6mEUsBArFJgQ77O1fSazHKtDymmxw8rd4S6cEG4WrqCYNgflKo59B2/RU0mSAYwghMF5VOKLoz9sy1kA4m1rHmPk01MqNKwH1oezkA1kZxqErkYMaXGTm9lO5RwLfFdcmb1ZbgPNIKxcsgxImFn/7PgCzcpo=
Message-ID: <d4757e60050505110838ead1fa@mail.gmail.com>
Date: Thu, 5 May 2005 14:08:23 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Extremely poor umass transfer rates
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050505082250.GA2594@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3YjKy-72a-21@gated-at.bofh.it> <3YkGD-7NT-15@gated-at.bofh.it>
	 <3Ylt2-8mA-7@gated-at.bofh.it> <3YlWb-px-35@gated-at.bofh.it>
	 <3YCkl-5lB-21@gated-at.bofh.it> <4273E5B3.6040708@shaw.ca>
	 <d4757e6005050420133ecd39c6@mail.gmail.com>
	 <20050505082250.GA2594@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/05, Greg KH <greg@kroah.com> wrote:
> On Wed, May 04, 2005 at 11:13:55PM -0400, Joe wrote:
> > Something is definetly going on with either vfat or the USB drivers...
> > My ipod is unrunnable on linux now.  To put it plainly, it transfers
> > painfully slow (on USB 2.0 mind you), it randomly ceases to respond
> > during file transfers.. and will only respond if replugged in.. its
> > corrupted my music and the fs to the point where i've now done two
> > low-level formats, and every time i put the stuff back on, the same
> > problems persist.
> 
> Are you using the ub or usb-storage driver?
> 
> thanks,
> 
> greg k-h
> 

Using usb-storage.  I double checked that it wasn't a hardware failure
on the ipod by adding stuff to it in windows... It performed
perfectly.

Thanks again,

Joe
