Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271002AbTGPSHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271028AbTGPSGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:06:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24713 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270972AbTGPSFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:05:32 -0400
Date: Wed, 16 Jul 2003 15:17:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: ajoshi@kernel.crashing.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb 0.1.9 against 2.4.21pre2 (fwd)
In-Reply-To: <Pine.LNX.4.10.10307161258230.21751-100000@gate.crashing.org>
Message-ID: <Pine.LNX.4.55L.0307161514050.12905@freak.distro.conectiva>
References: <Pine.LNX.4.10.10307161258230.21751-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jul 2003 ajoshi@kernel.crashing.org wrote:

>
>
> Many of these have already been addressed in 0.1.9,

He is talking about 0.1.9. The issues he complained about are present in
0.1.9. I havent read one line of code, but I know him enough to know he's
has no reason to lie or come up with non-existant bugs.

Please resend me a patch when you really have addressed the issues
Benjamin pointed out (0.1.10 or whatever).

For now I'll stick to 0.1.8 + his fixes.

> though I added the usage of the native clock, assertion for it, the dvi
> blanking, and the nolcd passthrough.  For things like the updated PM
> code, a patch would be helpful.
