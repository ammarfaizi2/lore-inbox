Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267627AbRG2PBV>; Sun, 29 Jul 2001 11:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267880AbRG2PBC>; Sun, 29 Jul 2001 11:01:02 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:7178 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267627AbRG2PAu>;
	Sun, 29 Jul 2001 11:00:50 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Fr d ric L. W. Meunier" <0@pervalidus.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SLIP and slhc as modules 
In-Reply-To: Your message of "Sun, 29 Jul 2001 07:21:52 -0300."
             <20010729072152.K135@pervalidus> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Jul 2001 01:00:41 +1000
Message-ID: <11303.996418841@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001 07:21:52 -0300, 
Fr d ric L. W. Meunier <0@pervalidus.net> wrote:
>Hi. I build PPP and SLIP as modules, but slhc is always built
>in. In 2.4.7 I disabled SLIP, and slhc was built as a module.
>
>Why not when I build SLIP as a module ?

http://marc.theaimsgroup.com/?l=linux-netdev&m=99628442702543&w=2
Same problem description, but with a patch.  I hope DaveM will take the
patch.

