Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271629AbRHPTkq>; Thu, 16 Aug 2001 15:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271627AbRHPTkg>; Thu, 16 Aug 2001 15:40:36 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:8204 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S271630AbRHPTkZ>; Thu, 16 Aug 2001 15:40:25 -0400
Date: Thu, 16 Aug 2001 22:54:12 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Magnus Naeslund(f)" <mag@fbab.net>
cc: Alexander Viro <viro@math.psu.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <Pine.LNX.4.30.0108162009260.2660-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.30.0108162251040.2660-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Aug 2001, Szabolcs Szakacsits wrote:
> On Wed, 15 Aug 2001, Magnus Naeslund(f) wrote:
> > The problem is that i can shh in as root, but not as any other user ( not
> > via login or su or either ).
> Are you using < 0.73 PAM without the change_uid pam_limit option? You

Uhm, this wanted to be "... < 0.73 OR >= 0.73 without the ...."

	Szaka

