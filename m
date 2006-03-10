Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWCJBPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWCJBPc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbWCJBPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:15:31 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:16060 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932696AbWCJBPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:15:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ozj4h6JCtq5QHYH28hxFXwovl0MoTYdaANiMaeXXw8y56gQODrwj0//8q9Z7OaIeXGsKp9QOz5X3liXjiQ+8MvJ6TGsIWyehhnbKaMeYhTEsX1SpRRrEHI8PF5oqDhdmFDTr8yuJBl5h8Ui356KxEFvP5QF9IB6PgwVTc9rke3M=
Message-ID: <38c09b90603091715u42f79fd5ne8cb62b8f8ddba7e@mail.gmail.com>
Date: Fri, 10 Mar 2006 09:15:28 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Cc: "Daniel Ritz" <daniel.ritz@gmx.ch>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>,
       "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
In-Reply-To: <20060309004349.GB1376@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603082346.37479.daniel.ritz@gmx.ch>
	 <20060309004349.GB1376@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

merging is the wonderful way. i love all in one :))

but, every vendor has their own USB Vendor ID.
How to overcome the issue?

Lanslott Gish



On 3/9/06, Greg KH <greg@kroah.com> wrote:
> On Wed, Mar 08, 2006 at 11:46:36PM +0100, Daniel Ritz wrote:
> > > And what about merging with the existing driver?
> >
> > something like this? it's compile tested only. not even tested
> > on an egalax screen since i don't have it around...
> > if this is ok, we could also merge itmtouch and mtouchusb into a
> > single driver.
>
> Looks ok to me.  Would be nice to get a verification from someone who
> has the device :)
>
> thanks,
>
> greg k-h
>



--
L.G, Life's Good~
