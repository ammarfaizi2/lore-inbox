Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291339AbSBHCV1>; Thu, 7 Feb 2002 21:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291353AbSBHCVR>; Thu, 7 Feb 2002 21:21:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291339AbSBHCVA>;
	Thu, 7 Feb 2002 21:21:00 -0500
Message-ID: <3C633608.2D0CDC51@mandrakesoft.com>
Date: Thu, 07 Feb 2002 21:20:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Turvey <turveysp@ntlworld.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre9
In-Reply-To: <Pine.LNX.4.21.0202071646550.17201-100000@freak.distro.conectiva> <002001c1b045$631ad760$030ba8c0@mistral>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Turvey wrote:
> 
> Can you tell me if the final 2.4.18 will solve the problems with recent
> binutils?  Or is the onus on the binutils maintainer to fix this?

What driver are you having problems with?

Typically this problem is solved by a one-line fix to a specific driver,
in 2.4.x.

	Jeff




-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
