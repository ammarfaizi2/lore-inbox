Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRB0JdZ>; Tue, 27 Feb 2001 04:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRB0JdP>; Tue, 27 Feb 2001 04:33:15 -0500
Received: from bcnfwl02.retevision.es ([62.81.27.241]:63383 "EHLO
	avinoe02.retevision.es") by vger.kernel.org with ESMTP
	id <S129624AbRB0Jcz> convert rfc822-to-8bit; Tue, 27 Feb 2001 04:32:55 -0500
Subject: increasing the number of file descriptors
To: linux-kernel@vger.kernel.org
Cc: whawes@star.net
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OFA7D9F891.904FF16B-ONC1256A00.0031BFB0@retevision.es>
From: rsaura@retevision.es
Date: Tue, 27 Feb 2001 10:39:46 +0100
X-MIMETrack: Serialize by Router on AVINOE02/SRV/EXT_RETEVISION(Release 5.0.4a |July 24, 2000) at
 02/27/2001 10:23:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


      I've recently hit a problem with a httpd process running out of space
      for more fd.

      While I'm seriouly looking for a fd-leak in the php-development
      behind the web server, I realized that i didn't know how to increase
      this parameter.

      Is there any /proc interface for increasing the number of file
      descriptors per process?

      Must I recompile? maybe changes must be made to files_struct?

      I've seen a patch for "variable fd array patch for 2.1.90" from Bill
      Hawes, is there a patch for 2.2.x or 2.4.x kernels?


      Please CC answers to rsaura@retevision.es

      TAI.

          Raúl Saura.



La información incluida en el presente correo electrónico es CONFIDENCIAL,
siendo para el uso exclusivo del destinatario arriba mencionado. Si usted
lee este mensaje y no es el destinatario señalado, el empleado o el agente
responsable de entregar el mensaje al destinatario, o ha recibido esta
comunicación por error, le informamos que está totalmente prohibida
cualquier divulgación, distribución o reproducción de esta comunicación, y
le rogamos que nos lo notifique, nos devuelva el mensaje original a la
dirección arriba mencionada y borre el mensaje.
Gracias.

