Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTB0WY6>; Thu, 27 Feb 2003 17:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTB0WXw>; Thu, 27 Feb 2003 17:23:52 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:28570 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267268AbTB0WXl>; Thu, 27 Feb 2003 17:23:41 -0500
Message-ID: <20030227223335.23607.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2003 23:33:35 +0100
Subject: Mouse generating two mouse click events instead of one
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
 
First of all, excuse me if this question is out of place, but I don't know for sure if this is a kernel problem. I'm 
running 2.5.63-mm1 under Red Hat Phoebe Beta3 linux distribution. I have a Intellimouse USB Explorer mouse 
attached and, when working on KDE3.1 I have noticed that if I single click the mouse very quickly, nearly all the 
times two click events are generated instead of one. 
 
I started to notice this with KDE3.1 menus: single clicking with the left button over the KDE button very fast (the 
time elapsed since I press the button and then release it is practically zero) made the menu appear and then 
disappear.  If I single click the left button, but this time, I do it slower, it works as expected. I don't know of this is 
a timing, threading or mouse event problem. Not only does this happens with buttons, but with other graphical 
elements like checkboxes (single clicking very fast, makes the checkbox get checked and immediately, 
unchecked). Has anyone experienced this before? 
 
Also, I feel sorry I can't be more explicit, but I have never had this problem while running a 2.4 kernel. At least, I 
have not noticed this in the past. 
 
Best regards, 
 
   Felipe Alfaro Solana 
 
PS: I want to help on finding the culprit to this, so please, don't hesitate to contact me for further information or 
assistance. 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
