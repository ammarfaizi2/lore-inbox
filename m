Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWCJC1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWCJC1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWCJC1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:27:05 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:6018 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752015AbWCJC1E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:27:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FsDmZkWEsvkql8prYjG+Cg7tLmZtwmHHnQFwQ5+IK49kCT3V8a31e5NrXrsydrr1j3UJcfvwKCErk04jlbUnOddFV9UAz2DSvYTv6+Te4OKuflbzuzLvuF4qGVmpWYk5FtAauCmHTsxSlNnjKusO4IVac1/+PozyTWCAq6wtnyQ=
Message-ID: <38c09b90603091826k1743d129tb24ca875282db991@mail.gmail.com>
Date: Fri, 10 Mar 2006 10:26:59 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [PATCH] add support for PANJIT TouchSet USB Touchscreen Device
Cc: "Daniel Ritz" <daniel.ritz@gmx.ch>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>,
       "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
In-Reply-To: <20060310013039.GA26532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603082346.37479.daniel.ritz@gmx.ch>
	 <20060309004349.GB1376@kroah.com>
	 <38c09b90603091715u42f79fd5ne8cb62b8f8ddba7e@mail.gmail.com>
	 <20060310013039.GA26532@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

look great!
i got the TouchSet usb hardware and could help to test about this.

Lanslott Gish

On 3/10/06, Greg KH <greg@kroah.com> wrote:
> On Fri, Mar 10, 2006 at 09:15:28AM +0800, Lanslott Gish wrote:
> > Hi,
> >
> > merging is the wonderful way. i love all in one :))
> >
> > but, every vendor has their own USB Vendor ID.
> > How to overcome the issue?
>
> Keep adding them to the device table?  Just like other drivers that
> support more than one type of device :)
>
> thanks,
>
> greg k-h
>


--
L.G, Life's Good~
