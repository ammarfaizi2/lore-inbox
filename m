Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSGIQmn>; Tue, 9 Jul 2002 12:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSGIQml>; Tue, 9 Jul 2002 12:42:41 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:64269 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317326AbSGIQmf>; Tue, 9 Jul 2002 12:42:35 -0400
Subject: Re: freezing afer switching from graphical to console
From: Michael Gruner <stockraser@yahoo.de>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207091227.15957.bernd-schubert@web.de>
References: <1026193021.1076.29.camel@highflyer> 
	<200207091227.15957.bernd-schubert@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1026232702.757.9.camel@highflyer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Jul 2002 18:39:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ok, did it as you say: in the BIOS I switched to Vsync/blank screen.
Let's see what happens.

BTW: My graphics card isn't a nvidia as many of you suggested but an ATI
Rage pro (what did you wrote Bernd? ;-) ).

Another interesting thing I got back in mind today was: one day my XMMS
played a mp3 song and I switched to console (oooops...you know what
happend) but the song kept on playing in a loop that was some
milliseconds until I powered the box off. I don't know what to think
about that.

best regards,
 michael

Am Die, 2002-07-09 um 12.27 schrieb Bernd Schubert:
> Hi, 
> 
> we have seen it, too. Seems to be graphics card dependend (ati ones are not 
> effected, but nvidia cards are ) and what powersaving mode is enabled in the 
> BIOS (Suspend for the Monitor causes a lock up when switching from X to the 
> console, but when using VSync/empty screen (or something like this) all works 
> fine).
> 
> Bernd
> 
-- 
Windmuehlenweg 22 07907 Schleiz
mobil: +491628955029
e-Mail: Michael.Gruner@fh-hof.de


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

