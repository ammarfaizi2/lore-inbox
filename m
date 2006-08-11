Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWHKOF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWHKOF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 10:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWHKOF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 10:05:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:16182 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751129AbWHKOF6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 10:05:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fTpyF38oiUQfEeJ5woDXvMmWwz2pLFwl23g84A2FOEHZ8HmBXnmUzbU3lTWAL5VXgp4McT40Zj6LZGk4RxqKbbH07gz9WW8uxO/oNrF0qLREzr+DjI3BTB7egOOoQOkTzkoq9+0KAHSQICXRWru5YkTdaoDcHCA0+TfzVkb1QoY=
Message-ID: <81b0412b0608110705y75cd5307vf73dd0b6ee107f81@mail.gmail.com>
Date: Fri, 11 Aug 2006 16:05:52 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Nicholas Miell" <nmiell@comcast.net>
Subject: Re: Announcing free software graphics drivers for Intel i965 chipset
Cc: "Jeff Garzik" <jeff@garzik.org>, keith.packard@intel.com,
       Linux-kernel@vger.kernel.org, "Dirk Hohndel" <dirk.hohndel@intel.com>,
       "Imad Sousou" <imad.sousou@intel.com>
In-Reply-To: <1155190917.2349.4.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155151903.11104.112.camel@neko.keithp.com>
	 <44DACD51.7080607@garzik.org> <1155190917.2349.4.camel@entropy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Nicholas Miell <nmiell@comcast.net> wrote:
> > > The Intel Open Source Technology Center graphics team is pleased to announce
> > > the immediate availability of free software drivers for the Intel(r) 965
> > > Express Chipset family graphics controller. These drivers include support
> > > for 2D and 3D graphics features for the newest generation Intel graphics
> > > architecture. The project Web site is http://IntelLinuxGraphics.org.
> >
...
>
> More importantly, where's the source to intel_hal.so?
>

...and what'd break if the call to intel_hal_set_content_protection is omited?
