Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbRFRTJt>; Mon, 18 Jun 2001 15:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbRFRTJj>; Mon, 18 Jun 2001 15:09:39 -0400
Received: from armitage.toyota.com ([63.87.74.3]:24329 "EHLO
	armitage.toyota.com") by vger.kernel.org with ESMTP
	id <S262436AbRFRTJa>; Mon, 18 Jun 2001 15:09:30 -0400
Message-ID: <3B2E51E0.92C9D65F@lexus.com>
Date: Mon, 18 Jun 2001 12:09:20 -0700
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ted Gervais <ve1drg@ve1drg.com>
CC: linux-kernel@vger.kernel.org
Subject: [OT] Re: ipchains
In-Reply-To: <Pine.LNX.4.21.0106181256120.2050-100000@ve1drg.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted Gervais wrote:

> I just ran into something odd. To me anyways, it was odd.
> I just installed and brought up kernel 2.4.5 and my ipchains failed.
> So I upgraded to the latest (that I could find) ipchains-1.3.10, and
> that also fails.
>
> Has anyone got any version of ipchains to work with the new(er) kernels?

For what it's worth, Red Hat 7.1 ships iptables
with ipchains emulation, which works out of the
box on their 2.4.2 kernel

cu

jjs

