Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312290AbSCTXol>; Wed, 20 Mar 2002 18:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312294AbSCTXoV>; Wed, 20 Mar 2002 18:44:21 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:9457 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312290AbSCTXoM>; Wed, 20 Mar 2002 18:44:12 -0500
Message-ID: <3C991EC9.1AD88D0C@eyal.emu.id.au>
Date: Thu, 21 Mar 2002 10:44:09 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre4: stardis.c still uses 'busy'
In-Reply-To: <Pine.LNX.4.21.0203201757560.9129-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> So here goes pre4, now with a much more detailed changelog...
> 

/drivers/media/video/stradis.c probably is missing the 'users' update.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
