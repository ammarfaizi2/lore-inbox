Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131387AbRAaItd>; Wed, 31 Jan 2001 03:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRAaItN>; Wed, 31 Jan 2001 03:49:13 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:56847 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131387AbRAaItE>;
	Wed, 31 Jan 2001 03:49:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: arjan@fenrus.demon.nl (Arjan van de Ven)
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o 
In-Reply-To: Your message of "Wed, 31 Jan 2001 09:46:19 BST."
             <m14NsuB-000OZJC@amadeus.home.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 19:48:57 +1100
Message-ID: <1575.980930937@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 09:46:19 +0100 (CET), 
arjan@fenrus.demon.nl (Arjan van de Ven) wrote:
>Unfortionatly, this is impossible. The miropcm config question is asked
>before the "sound" question, and the aci question is asked after that (all
>in ake config). In 2.2.x we have an #ifdef in the driver that causes an
>#error with a description of the problem and the solution. Someone stripped
>that #ifdef out of the driver during 2.3.something.

I thought the config problem was too hard for the current config
language.  Oh well, just have to wait until CML2 is part of the kernel,
sometime in 2.5.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
