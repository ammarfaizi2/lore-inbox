Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290094AbSAKUTw>; Fri, 11 Jan 2002 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290095AbSAKUTm>; Fri, 11 Jan 2002 15:19:42 -0500
Received: from lila.inti.gov.ar ([200.10.161.32]:31719 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S290094AbSAKUTh>;
	Fri, 11 Jan 2002 15:19:37 -0500
Message-ID: <3C3F4951.FD45C487@inti.gov.ar>
Date: Fri, 11 Jan 2002 17:21:38 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, raul@dif.um.es,
        linux-kernel@vger.kernel.org
Subject: Re: compaq presario 706 EA via 686a sound card
In-Reply-To: <E16P7kZ-0000A0-00@the-village.bc.nu> <3C3F4387.E8330684@inti.gov.ar> <3C3F46D5.3DFF5B57@inti.gov.ar>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More on the topic: That *is* AD1886 and ALSA should support it:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0107.0/0389.html

Note: I don't see EAPD control in this code, but it could explain why using ALSA
doesn't help ;-)

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



