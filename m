Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282303AbRKZTFd>; Mon, 26 Nov 2001 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282329AbRKZTDp>; Mon, 26 Nov 2001 14:03:45 -0500
Received: from host213-123-133-159.in-addr.btopenworld.com ([213.123.133.159]:17158
	"EHLO ambassador.mathewson.int") by vger.kernel.org with ESMTP
	id <S282062AbRKZTCP>; Mon, 26 Nov 2001 14:02:15 -0500
Message-Id: <200111261902.fAQJ27U09373@ambassador.mathewson.int>
Subject: Loopback sound driver?
To: linux-kernel@vger.kernel.org
From: Joseph Mathewson <joe@mathewson.co.uk>
Reply-to: joe.mathewson@btinternet.com
Date: Mon, 26 Nov 2001 19:02:06 -0000
X-Mailer: TiM infinity-ALPHA6-rc0.9-jjm
X-TiM-Client: 192.168.0.108 [192.168.0.108]
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone yet written a loopback sound driver, that is a module that provides a
"fake" /dev/dsp that will actually save sound to file on disk rather than
playing thru a hardware sound card.  Or am I being stupid here?  Is there some
/dev trick I can play?

If no such module exists, could a kind soul point me at sound module
documentation/API.  I can find a lot of compatibility lists, but little
programming reference.  Or is there a very simple sound card driver that could
be used as a starting point?

Thanks

Joe.

+-------------------------------------------------+
| Joseph Mathewson <joe@mathewson.co.uk>          |
+-------------------------------------------------+
