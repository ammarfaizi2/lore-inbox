Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311594AbSCNLwi>; Thu, 14 Mar 2002 06:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311593AbSCNLw3>; Thu, 14 Mar 2002 06:52:29 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:36107 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S311592AbSCNLwS>; Thu, 14 Mar 2002 06:52:18 -0500
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: [PATCH 2.4.19-pre3] New wireless driver API part 1
Date: 14 Mar 2002 12:52:15 +0100
Organization: Cistron Group
Message-ID: <a6q2tf$1ul$1@picard.cistron.nl>
In-Reply-To: <3C901455.5000704@mandrakesoft.com> <Pine.LNX.4.33.0203141139400.26308-100000@godzilla.axis.se>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0203141139400.26308-100000@godzilla.axis.se>,
Bjorn Wesen  <bjorn.wesen@axis.com> wrote:
>The orinico driver (already in the kernel) works fine with the DWL-650 card. 
>Tried it some days ago.. not a very big field trial but I inserted the card 
>and I got an eth0 from it and it worked, so thats the way I like it :)

Last time I tried the orinoco driver it failed to see my Lucent orinoco
card. The wlan-cs driver from the pcmcia sources works just fine though.

Wichert.


-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

