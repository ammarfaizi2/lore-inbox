Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279574AbRJXTOc>; Wed, 24 Oct 2001 15:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279575AbRJXTOY>; Wed, 24 Oct 2001 15:14:24 -0400
Received: from freeside.toyota.com ([63.87.74.7]:20486 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279574AbRJXTOK>;
	Wed, 24 Oct 2001 15:14:10 -0400
Message-ID: <3BD7131C.5B939BE@lexus.com>
Date: Wed, 24 Oct 2001 12:14:36 -0700
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
CC: "David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: acenic breakage in 2.4.13-pre
In-Reply-To: <20011024204913.A18191@sith.mimuw.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Rekorajski wrote:

> No. It's plain old egcs 1.1.2 (gcc 2.91.66). I can try with gcc 2.95.x
> but 2.96 or 3.x are no-no for me :)

That's bizzare, 2.96 has been working nicely
on all of my 30-40 Red Hat 7.x boxes. All sorts
of configs, from single P5-166 to Quad PPRO
with highmem, various vendors -

web, mail, dns, firewall, vpn, X workstations,
database, and all running kernels compiled
with gcc-2.96 , and everything running like
a top.

cu

jjs




