Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUEMUaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUEMUaC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbUEMU21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:28:27 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:4613 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264693AbUEMU14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:27:56 -0400
Date: Thu, 13 May 2004 17:25:30 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: Eric Valette <eric.valette@free.fr>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm2 : suddent lost of keyboard. Everything else OK.
Message-ID: <20040513202530.GB730@lorien.prodam>
Mail-Followup-To: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>,
	Eric Valette <eric.valette@free.fr>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040513195250.GA3303@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040513195250.GA3303@debian>
User-Agent: Mutt/1.4.2i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 13, 2004 at 04:52:50PM -0300, Ramón Rey Vicente escreveu:

| El jue, 13 de may de 2004, a las 09:15:29 +0200, Eric Valette dijo:
| 
| > I tested 2.6.6-mm2 this afternoon and twice I totally lost my
| keyboard. 
| > Everything else is working, I can rlogin, shutdown the system. It also
| > happens in console mode and looks like either keyboard irq or more 
| > likely its post processing just do not process queued characters.
| 
| In my system this is happening when I press the "caps lock" key.

 I think you found the problem, here it locks when I press "caps
lock" too.

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
