Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288158AbSAMV2I>; Sun, 13 Jan 2002 16:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288159AbSAMV17>; Sun, 13 Jan 2002 16:27:59 -0500
Received: from 62-36-191-244.dialup.uni2.es ([62.36.191.244]:12928 "EHLO
	raul.dif.um.es") by vger.kernel.org with ESMTP id <S288158AbSAMV1w>;
	Sun, 13 Jan 2002 16:27:52 -0500
Subject: Re: Driver via ac97 sound problem (VT82C686B)
From: Raul Sanchez Sanchez <raul@dif.um.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Lorenz <p1orenz@yahoo.com>, salvador@inti.gov.ar,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16PZOe-0003fZ-00@the-village.bc.nu>
In-Reply-To: <E16PZOe-0003fZ-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Jan 2002 22:22:45 +0100
Message-Id: <1010956965.3260.0.camel@raul>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I have write the lines referenced to ad1886 in the patch that Salvador
Eduardo Tropea indicate me in next direction:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0107.0/0389.html

ad1886 is recognized and the code of setup_ad1886 is executed, i have
put a printk in the function and i can see it. 

The problem is that i can't hear any sound :( It's seem to be mute on

thanks 



-- 
-----------------------------------------------
Raul Sanchez Sanchez             raul@dif.um.es
Centro de Calculo               
Facultad de Informatica    Tlf: +34 968 36 4827 
Universidad de Murcia      Fax: +34 968 36 4151
-----------------------------------------------
