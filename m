Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263559AbTCUI3w>; Fri, 21 Mar 2003 03:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263560AbTCUI3w>; Fri, 21 Mar 2003 03:29:52 -0500
Received: from mario.gams.at ([194.42.96.10]:36696 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S263559AbTCUI3q> convert rfc822-to-8bit;
	Fri, 21 Mar 2003 03:29:46 -0500
X-Mailer: exmh version 2.6.1 18/02/2003 with nmh-1.0.4
From: Bernd Petrovitsch <bernd@gams.at>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Release of 2.4.21 
References: <200303210013.h2L0D0jx000566@81-2-122-30.bradfords.org.uk> 
In-reply-to: Your message of "Fri, 21 Mar 2003 00:13:00 GMT."
             <200303210013.h2L0D0jx000566@81-2-122-30.bradfords.org.uk> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 21 Mar 2003 09:40:45 +0100
Message-ID: <15812.1048236045@frodo.gams.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> wrote:
>>Why can't we just make all releases smaller and more frequent?
>
>Why do we need 2.4.x-pre at all, anyway - why can't we just test
>things in the -[a-z][a-z] trees, and _start_ with -rc1?
>
>Why can't we just do bugfixes for 2.4, and speed up 2.5 development?

Because 2.4 is used on (real) production systems - even my desktop PC
on my workplace is considered a production system - which (at least)
should run and therefore trying 2.5 is not an option (and no, no way).
And then it takes 1.5 years for the next stable kernel release which 
implies that quite new hardware (without an existing driver) cannot be
used for any production-like system.
IOW you would just loose a lot real use and testing of backported 
stuff and new hardware drivers.
And no, I don't think that someone wants that.

	Bernd

-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


