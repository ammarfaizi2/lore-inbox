Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272404AbRIQKF4>; Mon, 17 Sep 2001 06:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272548AbRIQKFq>; Mon, 17 Sep 2001 06:05:46 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:23302 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272404AbRIQKFk>; Mon, 17 Sep 2001 06:05:40 -0400
Date: Mon, 17 Sep 2001 12:06:03 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
Message-ID: <20010917120603.B13815@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu> <20010915083236.A9271@bessie.localdomain> <20010915135118.A24067@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010915135118.A24067@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2001, Mike Fedyk wrote:

> Either way, you'd have a system you can't reboot without hardware reset if
> you have a process stuck in D state on a rw FS.

That is EVIL, so eventually, the umount must succeed at all costs.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
