Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbTBFMll>; Thu, 6 Feb 2003 07:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTBFMlk>; Thu, 6 Feb 2003 07:41:40 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:13746 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267021AbTBFMlk>; Thu, 6 Feb 2003 07:41:40 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Dave Jones <davej@codemonkey.org.uk>, Jurriaan <thunder7@xs4all.nl>
Subject: Re: 2.5.59 won't boot, 2.5.58 will, how to I use bitkeeper to get 'in between' ?
Date: Thu, 6 Feb 2003 13:51:00 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <20030206060742.GA6458@middle.of.nowhere> <20030206123340.GA3305@codemonkey.org.uk>
In-Reply-To: <20030206123340.GA3305@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302061351.01369.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 February 2003 13:33, Dave Jones wrote:
> On Thu, Feb 06, 2003 at 07:07:42AM +0100, Jurriaan wrote:
>  > Until now, all 2.5.59-based kernels (2.5.59 vanilla, 2.5.59 + vmlinux
>  > patch, 2.5.59-mm[1-8]) hang very early in the boot-process on my system,
>  > right after 'Uncompressing Linux...'
>
> Two suspects (from freezing boxes Ive had here) are ACPI and PNP. Try
> disabling those first.

Do you have a K6-2?  I know of two K6-2 400MHz boxes that freeze at the
same point with recent (2.5.58-2.5.59, maybe 2.5.57) kernels.

Ciao,

Duncan.
