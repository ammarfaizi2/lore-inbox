Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFNGV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFNGV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFNGV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:21:58 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:43429 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261161AbVFNGV4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:21:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BNtggKPnKYorLOB45i92rAz0Z/w98qi56eCQmmJqR++l/XHXABXQnITMOuM3hd2A+29gpF/NRzPuwam+fnOtFBGb2y9I2s64JvXE/Xc26XDOXVqvvtd86dmajwTgq+5rVRPyKP7M412BZ2N9RehU4vCgMR+ENgcM2WLj59oP1Ns=
Message-ID: <9e473391050613232170f57ea3@mail.gmail.com>
Date: Tue, 14 Jun 2005 02:21:53 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: Input sysbsystema and hotplug
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050613221657.GB15381@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506131607.51736.dtor_core@ameritech.net>
	 <20050613221657.GB15381@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/05, Greg KH <gregkh@suse.de> wrote:
> > where inputX are class devices, mouse and event are subclasses of input
> > class and mouseX and eventX are again class devices.
> 
> Yes, lots of people want class devices to have children.  Unfortunatly
> they don't provide patches with their requests :)

I did, but you didn't like it.

> 
> thanks,
> 
> greg k-h

-- 
Jon Smirl
jonsmirl@gmail.com
