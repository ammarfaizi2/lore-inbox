Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbTDNNi0 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263296AbTDNNi0 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:38:26 -0400
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:31507 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id S263261AbTDNNiX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:38:23 -0400
From: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
To: linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: stabilty problems using opengl on kt400 based system
Date: Mon, 14 Apr 2003 15:50:03 +0200
User-Agent: KMail/1.5.1
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be> <200304140922.h3E9Lvu02312@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200304140922.h3E9Lvu02312@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141550.04083.frank.vandamme@student.kuleuven.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 11:16, Denis Vlasenko wrote:
> On 12 April 2003 15:10, Frank Van Damme wrote:
> > compiling. However, if Istart running OpenGL applications (games)
> > (quake,tuxracer or whatever) themachine will freeze in anything from
> > 2 minutes to an hour. The last frame remains on the screen, but I can
> > still login over ssh and reboot. The drivers of this card are only
>
> Can you login over ssh and collect useful info?
> Top, ps, various /proc/* files?

Yes, what I noticed is that a) the app in question disappears immediately when 
the problem occurs (but the image on the screen freezes) and b) which Nuno 
Silva said: X starts eating all the cpu (instead of the app). 

-- 
Frank Van Damme    | "Saying 8MB of RAM doesn't do as much anymore is
http://www.        | like saying a gallon of water holds more than it
openstandaarden.be | did in 1988."                    --George Adkins

