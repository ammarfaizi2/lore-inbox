Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261887AbREPMFF>; Wed, 16 May 2001 08:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261889AbREPMEz>; Wed, 16 May 2001 08:04:55 -0400
Received: from bcnfwl02.retevision.es ([62.81.27.241]:38464 "EHLO
	avinoe02.retevision.es") by vger.kernel.org with ESMTP
	id <S261887AbREPMEq> convert rfc822-to-8bit; Wed, 16 May 2001 08:04:46 -0400
Subject: Hidden interfaces on 2.4.x kernels
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF2434A91A.53D55D6A-ONC1256A4E.004188B6@retevision.es>
From: rsaura@retevision.es
Date: Wed, 16 May 2001 14:05:05 +0200
X-MIMETrack: Serialize by Router on AVINOE02/SRV/EXT_RETEVISION(Release 5.0.6a |January
 17, 2001) at 05/16/2001 02:03:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

      Several months ago I set up a lvs cluster on smtp servers on 2.2.16
      kernels, which now I'm planning to move to 2.4.4.

      I am using direct routing alternative so I configure a lo:0 interface
      with the address of the virtualserver on every local node so it can
      process the mails as its own, but I can't find
      /proc/sys/net/ipv4/conf/hidden anywhere in my proc fs.

      where did it go?
      How can I set up a silent interface that don't send arps in 2.4
      kernels?

      TIA

      Please answer directly to me because I am not subscribed.


          Ra�l
La informaci�n incluida en el presente correo electr�nico es CONFIDENCIAL,
siendo para el uso exclusivo del destinatario arriba mencionado. Si usted
lee este mensaje y no es el destinatario se�alado, el empleado o el agente
responsable de entregar el mensaje al destinatario, o ha recibido esta
comunicaci�n por error, le informamos que est� totalmente prohibida
cualquier divulgaci�n, distribuci�n o reproducci�n de esta comunicaci�n, y
le rogamos que nos lo notifique, nos devuelva el mensaje original a la
direcci�n arriba mencionada y borre el mensaje.
Gracias.

