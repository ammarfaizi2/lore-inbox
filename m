Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284867AbRLFAB6>; Wed, 5 Dec 2001 19:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284870AbRLFABs>; Wed, 5 Dec 2001 19:01:48 -0500
Received: from mailf.telia.com ([194.22.194.25]:11491 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S284867AbRLFABa>;
	Wed, 5 Dec 2001 19:01:30 -0500
Date: Thu, 6 Dec 2001 01:11:50 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre4 extra-version
Message-ID: <20011206001150.GA10592@telia.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C0EB178.4A599A31@isn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C0EB178.4A599A31@isn.net>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 07:44:56PM -0400, Garst R. Reese wrote:

> It really does help to keep extra version uptodate ;)
> Can someone write a perl script to tie a string around Marcelo's finger?

Huh? From -pre4:

 VERSION = 2
 PATCHLEVEL = 4
 -SUBLEVEL = 16
 -EXTRAVERSION =
 +SUBLEVEL = 17
 +EXTRAVERSION = -pre4
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
