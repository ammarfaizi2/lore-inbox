Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285476AbRLGTaj>; Fri, 7 Dec 2001 14:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285480AbRLGTaU>; Fri, 7 Dec 2001 14:30:20 -0500
Received: from Mail.Trilogic.com ([207.190.245.162]:27915 "EHLO trilogic.com")
	by vger.kernel.org with ESMTP id <S285476AbRLGTaL>;
	Fri, 7 Dec 2001 14:30:11 -0500
Message-Id: <01Dec7.142641est.119045@bouncer.trilogic.com>
From: Todd Harrington <THarrington@trilogicsystems.com>
To: linux-kernel@vger.kernel.org
Subject: w83782d hangs during modprobe on Tyan
Date: Fri, 7 Dec 2001 14:27:02 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We are using a Tyan 2688 motherboard (WinBond w83782d). The problem that I
> am having is the lm_sensors package is hanging when I load the w83781d
> (modprobe w83781d) driver. 
> 
> We are using the lm_sensors 2.6.2 and i2c 2.6.2. I have also tried the CVS
> version and have done:
> 
> modprobe i2c-piix4
> modprobe w83781d init=0
> 
> I have also tried modprobe w83781d force_w83782d=0,0x29
> 
> The system still hangs.
> 
> I read on the linux-kernel mailing list a similar problem and it said
> there was a bug in the winbond driver but there was has been patch posted
> to bugtracker but the changes have not been integrated with CVS yet? Not
> sure if this related.
> 
> Hoping someone can help me!
> 
> Regards,
> 
> 
> 
> Todd Harrington
> Trilogic Systems
> Senior Systems Engineer
> Tel -  978-658-3800 x-151
> Fax - 978-657-5927
> todd@trilogic.com
> "Trilogic Systems:Providing you a full portfolio of 
> design, integration, certification and support services."
> 
> 
> 
