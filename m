Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRKXKhK>; Sat, 24 Nov 2001 05:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRKXKgt>; Sat, 24 Nov 2001 05:36:49 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:50446 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275552AbRKXKgn>; Sat, 24 Nov 2001 05:36:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Davies <james_m_davies@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Sound cutout.
Date: Sat, 24 Nov 2001 20:32:48 +1000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011124103649Z275552-17408+19197@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes. My ESS1370 just stops sometimes. usually when im flicking between tracks 
in xmms (i.e. /dev/dsp is getting initialised and uninitialised a few times a 
second). the only way to fix it is a reboot. I've tried reinserting the 
module, but it still doesnt work. This has happened on a few kernel versions 
in the 2.4 series, but it didnt happen in 2.2

On Sat, 24 Nov 2001, Patrick Cole wrote:
> Well my maestro3 works fine recording; cat /dev/dsp gives lots of
> rubbish. I have however noticed that on odd occasion it just stops
> working (no playing or nothing.. totally dead) and a reboot is
> required to get functionality back.  Anyone had this problem before?

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

