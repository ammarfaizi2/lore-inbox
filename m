Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292250AbSBTTsa>; Wed, 20 Feb 2002 14:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292249AbSBTTsV>; Wed, 20 Feb 2002 14:48:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11271 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292244AbSBTTsE>;
	Wed, 20 Feb 2002 14:48:04 -0500
Message-ID: <3C73FD6F.D4BDF5E7@mandrakesoft.com>
Date: Wed, 20 Feb 2002 14:47:59 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5 compile on alpha bombs
In-Reply-To: <20020220193600.GA24486@alpha.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan on Alpha wrote:
> 
> I'm not sure if it is meant to work, it being a development kernel and
> all, but if anybody is interested:

Cool, there are other users too ;-)

Yeah, Richard Henderson, alpha maintainer, is aware of it..  He already
has a fix for switch_to(), I'm not sure about the others...

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
