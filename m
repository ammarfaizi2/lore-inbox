Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269249AbTCBRLr>; Sun, 2 Mar 2003 12:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269250AbTCBRLr>; Sun, 2 Mar 2003 12:11:47 -0500
Received: from mario.gams.at ([194.42.96.10]:17768 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S269249AbTCBRLq> convert rfc822-to-8bit;
	Sun, 2 Mar 2003 12:11:46 -0500
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel source spellchecker 
References: <20030302165127Z269240-29902+1551@vger.kernel.org> 
In-reply-to: Your message of "Sun, 02 Mar 2003 10:56:59 PST."
             <20030302165127Z269240-29902+1551@vger.kernel.org> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sun, 02 Mar 2003 18:22:07 +0100
Message-ID: <27243.1046625727@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jared Daniel J. Smith" <linux@trios.org> wrote:
[...]
>constants=konstants
>konstants is German; is this intentional?
[...]
>invocation=invokation
>invokation is German; is this intentional?

Both may look German (since they have the 'k' instead of an 'c') but 
they seem more like Germanisms:
'constant' is (as a noun) "Konstante", the plural is "Konstanten"
(see e.g. http://dict.leo.org/?p=T8PXU.&search=constants).
'invokation' is absolutely not-existing in German, see
http://dict.leo.org/?p=T8PXU.&search=invocation. In case of function 
one would use "Aufruf" (similar to "call a function").

	Bernd, getting somewhat off-topic
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


