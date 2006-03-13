Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWCMBBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWCMBBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 20:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWCMBBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 20:01:48 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:23330 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932304AbWCMBBr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 20:01:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZKQ25hCPX0xasiQkGyXbZOv9OqHmNQ44bkR7ZeoVWyIFUPtF5+imOH5/IyO2Z4IrPjoHyV6BuS5r5x5dkyA8JVeJ4EeInDNP8YqfFzT0eqbbwpXZx1+42y+i4kpYyLCUyFnDPHIFDJsoJ0y8N4J64xNZVFL8n8qLgS4TeUYo7W8=
Message-ID: <38c09b90603121701q69c61221lf92bb150e419b1c9@mail.gmail.com>
Date: Mon, 13 Mar 2006 09:01:46 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
In-Reply-To: <200603112155.38984.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
	 <200603112155.38984.daniel.ritz-ml@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,
it's great. i will test touchset part today.

Regards,

Lanslott Gish

On 3/12/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> hi
>
> here my merge of the USB touchscreen drivers, based on my patch from
> thursday for touchkitusb. this time it's a new driver...
>
> and of course it's untested. i can test the egalax part next week...
>
> [ also cc'ing the authors of the other drivers ]
>
> the sizes for comparison:
>    text    data     bss     dec     hex filename
>    2942     724       4    3670     e56 touchkitusb.ko
>    2647     660       0    3307     ceb mtouchusb.ko
>    2448     628       0    3076     c04 itmtouch.ko
>    4097    1012       4    5113    13f9 usbtouchscreen.ko
>
> comments?
>
> rgds
> -daniel
>
