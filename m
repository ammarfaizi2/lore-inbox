Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRKYNf3>; Sun, 25 Nov 2001 08:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280600AbRKYNfQ>; Sun, 25 Nov 2001 08:35:16 -0500
Received: from dialin-145-254-223-057.arcor-ip.net ([145.254.223.57]:62962
	"HELO duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S277228AbRKYNfG>; Sun, 25 Nov 2001 08:35:06 -0500
Date: Sun, 25 Nov 2001 14:34:49 +0100
From: Dominik Kubla <kubla@sciobyte.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011125143449.B5506@duron.intern.kubla.de>
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.23i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 04:39:15PM -0200, Marcelo Tosatti wrote:

> - Correctly sync inodes in iput()			(Alexander Viro)

Given the  fact that  this bug  in a presumably  stable linux  kernel is
getting quite some attention in the media (electronic and otherwise). It
would be prudent  to get out a  2.4.16 which fixes this  bug right about
now.

Just my 2 cents...
  Dominik Kubla
-- 
ScioByte GmbH    Zum Schiersteiner Grund 2     55127 Mainz (Germany)
Phone: +49 700 724 629 83                    Fax: +49 700 724 629 84
1024D/717F16BB    A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
