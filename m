Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282904AbRK0LKM>; Tue, 27 Nov 2001 06:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282908AbRK0LKC>; Tue, 27 Nov 2001 06:10:02 -0500
Received: from web13106.mail.yahoo.com ([216.136.174.151]:23782 "HELO
	web13106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282904AbRK0LJv>; Tue, 27 Nov 2001 06:09:51 -0500
Message-ID: <20011127110950.61670.qmail@web13106.mail.yahoo.com>
Date: Tue, 27 Nov 2001 06:09:50 -0500 (EST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: Loopback sound driver?
To: joe.mathewson@btinternet.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111261902.fAQJ27U09373@ambassador.mathewson.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Joseph Mathewson <joe@mathewson.co.uk> a écrit :
> Has anyone yet written a loopback sound driver, that
> is a module that provides a
> "fake" /dev/dsp that will actually save sound to
> file on disk rather than
> playing thru a hardware sound card.  Or am I being
> stupid here?  Is there some
> /dev trick I can play?
> 
> If no such module exists, could a kind soul point me
> at sound module
> documentation/API.  I can find a lot of
> compatibility lists, but little
> programming reference.  Or is there a very simple
> sound card driver that could
> be used as a starting point?
> 
> Thanks
> 
> Joe.
> 
> +-------------------------------------------------+
> | Joseph Mathewson <joe@mathewson.co.uk>          |
> +-------------------------------------------------+
> -

Alsa ( http://www.alsa-project.org ) has a dummy sound
driver. Maybe it is usefull for you


__________________________________________________________
Obtenez votre adresse @yahoo.ca gratuite et en français !
courriel.yahoo.ca
