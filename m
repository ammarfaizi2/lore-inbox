Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132255AbRALTGw>; Fri, 12 Jan 2001 14:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132204AbRALTGc>; Fri, 12 Jan 2001 14:06:32 -0500
Received: from smtp4.libero.it ([193.70.192.54]:47251 "EHLO smtp4.libero.it")
	by vger.kernel.org with ESMTP id <S132152AbRALTGV>;
	Fri, 12 Jan 2001 14:06:21 -0500
From: Andrea Ferraris <andrea_ferraris@libero.it>
Reply-To: andrea_ferraris@libero.it
Date: Fri, 12 Jan 2001 20:02:44 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.31.0101112024250.9238-100000@neptun.fachschaften.tu-muenchen.de> <01011120083704.00618@depoffice.localdomain> <01011215001406.00925@af>
In-Reply-To: <01011215001406.00925@af>
Subject: Re: 2.4.0 Keyboard and mouse lock
MIME-Version: 1.0
Message-Id: <01011220024400.00934@af>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the noise, it has happened again, but this time I had
sysreq active and it worked. CTRL+ALT+BACKSPACE or 
ALT+FX didn't work. With sysreq I synced, umounted and 
rebooted without trouble.

I think that could be a mouse and/or X and/or Netscape problem,
since the system (apart input devices) was up and running.

	Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
