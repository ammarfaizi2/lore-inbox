Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291425AbSBNK06>; Thu, 14 Feb 2002 05:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291423AbSBNK0s>; Thu, 14 Feb 2002 05:26:48 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:16645
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S291425AbSBNK0m>; Thu, 14 Feb 2002 05:26:42 -0500
Date: Thu, 14 Feb 2002 11:26:39 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Michael Cohen <me@ohdarn.net>
Cc: Linuw-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre9-mjc2
Message-ID: <20020214112639.A13551@bouton.inet6-interne.fr>
Mail-Followup-To: Michael Cohen <me@ohdarn.net>,
	Linuw-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net> <1013663396.6651.19.camel@ohdarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1013663396.6651.19.camel@ohdarn.net>; from me@ohdarn.net on Thu, Feb 14, 2002 at 12:09:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 12:09:56AM -0500, Michael Cohen wrote:
> > SiS5513 updates	(20020128_1)		(Daniel Bouton)
> Erm, make that Lionel Bouton.  My apologies. :)
>

No problem.
But 20020128_1 has buggy chip capability detection code for most chipsets.
20020214_1 solves this (mostly, it doesn't work yet for chip not in the in-driver
database).

LB.
