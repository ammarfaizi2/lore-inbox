Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRKXTUb>; Sat, 24 Nov 2001 14:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279418AbRKXTUV>; Sat, 24 Nov 2001 14:20:21 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:57989 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S279277AbRKXTUP>; Sat, 24 Nov 2001 14:20:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de>
	<Pine.LNX.4.33L.0111241138070.4079-100000@imladris.surriel.com>
	<20011124103642.A32278@vega.ipal.net>
	<20011124184119.C12133@emma1.emma.line.org>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 24 Nov 2001 20:20:11 +0100
In-Reply-To: <20011124184119.C12133@emma1.emma.line.org> (Matthias Andree's message of "Sat, 24 Nov 2001 18:41:19 +0100")
Message-ID: <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> However, if it's really true that DTLA drives and their successor
> corrupt blocks (generate bad blocks) on power loss during block writes,
> these drives are crap.

They do, even IBM admits that (on

        http://www.cooling-solutions.de/dtla-faq

you find a quote from IBM confirming this).  IBM says it's okay, you
have to expect this to happen.  So much for their expertise in making
hard disks.  This makes me feel rather dizzy (lots of IBM drives in
use).

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
