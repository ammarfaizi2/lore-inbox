Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSGRGdl>; Thu, 18 Jul 2002 02:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318019AbSGRGdk>; Thu, 18 Jul 2002 02:33:40 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:14001 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318018AbSGRGdk> convert rfc822-to-8bit; Thu, 18 Jul 2002 02:33:40 -0400
Message-ID: <3D2A78FA00479A2C@mel-rta7.wanadoo.fr> (added by
	    postmaster@wanadoo.fr)
Date: Thu, 18 Jul 2002 09:36:33 +0200 (MET DST)
From: "Pierre ROUSSELET" <pierre.rousselet@wanadoo.fr>
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <3D308A30.7070702@wanadoo.fr> <20020717213332.GA10227@kroah.com> <3D2A7916004B5024@mel-rta10.wanadoo.fr>   <20020718060551.GB12626@kroah.com>
Subject: Re: 2.5.25  uhci-hcd  very bad  
MIME-Version: 1.0
Content-Type: text/plain;
 charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is OK with usb-uhci-hcd up to 2.5.24, you might as well suggest to un-plug it...


>Messsage du 18/07/2002 08:05
>De : Greg KH <greg@kroah.com>
>A : Pierre ROUSSELET <pierre.rousselet@wanadoo.fr>
>Copie à :  <linux-kernel@vger.kernel.org>
>Objet : Re: 2.5.25  uhci-hcd  very bad  
>
> On Thu, Jul 18, 2002 at 08:35:37AM +0200, Pierre ROUSSELET wrote:
> > The driver is made of a kernel module speedtch.o (built outside of the
> > tree) and of userspace modem firmware loader and management daemon
> > speedmgt.
> 
> I'd suggest asking the authors of the driver about this.
> 
> Good luck,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

