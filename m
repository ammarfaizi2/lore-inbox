Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265418AbSJaW1g>; Thu, 31 Oct 2002 17:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265425AbSJaW1g>; Thu, 31 Oct 2002 17:27:36 -0500
Received: from ulima.unil.ch ([130.223.144.143]:2182 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S265418AbSJaW1f>;
	Thu, 31 Oct 2002 17:27:35 -0500
Date: Thu, 31 Oct 2002 23:34:01 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Logitech wheel and 2.5? (PS/2)
Message-ID: <20021031223401.GB25356@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

up to 2.5.45:

...
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
...
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
...

And very regulary my mouse position is lost and reseted???
Also the wheel don't work (don't know for the button on the left that I
never use: the 3 regulars one and the wheel are enough for me...).

Thank you,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
