Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312401AbSDCUe7>; Wed, 3 Apr 2002 15:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDCUet>; Wed, 3 Apr 2002 15:34:49 -0500
Received: from web13108.mail.yahoo.com ([216.136.174.153]:28933 "HELO
	web13108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312400AbSDCUej>; Wed, 3 Apr 2002 15:34:39 -0500
Message-ID: <20020403203438.82460.qmail@web13108.mail.yahoo.com>
Date: Wed, 3 Apr 2002 21:34:38 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Screen corruption in 2.4.18
To: root@chaos.analogic.com
Cc: VANDROVE@vc.cvut.cz, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020403083605.10671A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Richard B. Johnson" <root@chaos.analogic.com>
wrote:
> if you have 32 MB of RAM in your screen-card, set
> the aperture size
> to 32 MB, not (!) 256 MB.

OK, I've reset the aperture to 32MB and I no longer
get screen corruption with xine. However, it appears
that there are a lot of different opinions on how to
best set the AGP aperture:

http://www.lostcircuits.com/advice/bios2/12.shtml

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
