Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSDVQz0>; Mon, 22 Apr 2002 12:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314276AbSDVQzZ>; Mon, 22 Apr 2002 12:55:25 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:64265 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S314271AbSDVQzX>;
	Mon, 22 Apr 2002 12:55:23 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: XFS in the main kernel
Date: 22 Apr 2002 18:55:20 +0200
Organization: Cistron Group
Message-ID: <aa1f9o$519$1@picard.cistron.nl>
In-Reply-To: <3CC427F4.12C40426@fnal.gov>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3CC427F4.12C40426@fnal.gov>,
Dan Yocum  <yocum@fnal.gov> wrote:
>I know it's been discussed to death, but I am making a formal request to you
>to include XFS in the main kernel.  We (The Sloan Digital Sky Survey) and
>many, many other groups here at Fermilab would be very happy to have this in
>the main tree.  

Has XFS been proven to be completely stable and POSIX complient in its
behaviour? The reason I am asking is that XFS seems to be a fairly common
factor for segfault bugreports in dpkg. The problems are rare enough (and
never reproducable) so I can't prove this but it does leave me wondering.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

