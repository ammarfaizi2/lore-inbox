Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbSKOS5S>; Fri, 15 Nov 2002 13:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSKOS5R>; Fri, 15 Nov 2002 13:57:17 -0500
Received: from holomorphy.com ([66.224.33.161]:54992 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266443AbSKOS5R>;
	Fri, 15 Nov 2002 13:57:17 -0500
Date: Fri, 15 Nov 2002 11:00:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dead & Dying interfaces
Message-ID: <20021115190040.GZ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 06:47:25PM +0000, Matthew Wilcox wrote:
> We forgot to remove a lot of crap interfaces during 2.5 development.
> Let's start a list now so we don't forget during 2.7.
> This list is a combination of interfaces which have gone during 2.5 and
> interfaces that should go during 2.7.  Think of it as a `updating your
> driver/filesystem to sane code' guide.

It's very possible (and in fact bugfixing) to incrementally convert
callers of these interfaces, even during freezes or stable releases.
A bugfix is a bugfix. =)


Cheers,
Bill
