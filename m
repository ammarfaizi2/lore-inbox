Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSLASrM>; Sun, 1 Dec 2002 13:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSLASrM>; Sun, 1 Dec 2002 13:47:12 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:63104
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S262326AbSLASrL>; Sun, 1 Dec 2002 13:47:11 -0500
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: xizard@enib.fr
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DEA322B.40204@enib.fr>
References: <3DEA322B.40204@enib.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1038768875.12518.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 01 Dec 2002 12:54:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-01 at 10:00, XI wrote:
> Hi,
> [1] With kernel-2.4.19 and kernel-2.4.20 the sound stutter, sizzle
> 
> [2] The problem seems be correlated with my PCI graphic card (matrox
> G200 PCI) and my sound card (sound blaster live 5.1).
> In fact every time I listen music and that something appens on my screen
> (moving a window, watching a movie) the sound stutter.

I had a similar problem. Turned out to be where my TV card was plugged
into + my mixer settings. I had the tv sound out plugged into mic,
instead of line in. Using aumix I was able to figure out that changing
which input was allowed to recored got rid of the noise. Have you
attempted such trouble shooting?

> I think the first thing I should do is to try different kernel version
> in order to find when this problem appeared first.

--The GrandMaster
