Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSEaIbs>; Fri, 31 May 2002 04:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSEaIbr>; Fri, 31 May 2002 04:31:47 -0400
Received: from [213.187.195.158] ([213.187.195.158]:57331 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP
	id <S315218AbSEaIbq>; Fri, 31 May 2002 04:31:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre9-ac3
In-Reply-To: <200205302322.g4UNMne06371@devserv.devel.redhat.com>
	<20020531014935.D9282@suse.de>
From: Marcus Sundberg <marcus@ingate.com>
Date: 31 May 2002 10:31:44 +0200
Message-ID: <vewutkogzz.fsf@inigo.ingate.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:

> Two points worth mentioning in regard to this.
> 1. The first type of speedstep (found in systems with BX chipsets)
>    isn't supported. Only the later type found in systems with ICH
>    chipsets will work with this driver..

What about MX chipsets? It seems to be mostly a BX without AGP,
but it has an ICH-like AC97-controller, so...

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
