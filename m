Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288983AbSANTWE>; Mon, 14 Jan 2002 14:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288977AbSANTUi>; Mon, 14 Jan 2002 14:20:38 -0500
Received: from [200.10.161.32] ([200.10.161.32]:65166 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S288969AbSANTRl>;
	Mon, 14 Jan 2002 14:17:41 -0500
Message-ID: <3C432F31.CE9652BC@inti.gov.ar>
Date: Mon, 14 Jan 2002 16:19:13 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Jeremy Lumbroso <j.lumbroso@noos.fr>
CC: Raul Sanchez Sanchez <raul@dif.um.es>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Paul Lorenz <p1orenz@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Driver via ac97 sound problem (VT82C686B)
In-Reply-To: <E16PZOe-0003fZ-00@the-village.bc.nu> <1010956965.3260.0.camel@raul> <3C4311BC.A99CEF31@inti.gov.ar> <E16QCE9-0003hR-00@samantha.inti.gov.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Lumbroso wrote:

> i apply the patch and compile with the two values but i still heard no sound .

:-(
Check the routines are really called, but then we should look in other place
because it discards the EAPD theory.

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



