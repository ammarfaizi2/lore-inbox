Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289989AbSAORYh>; Tue, 15 Jan 2002 12:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290047AbSAORY2>; Tue, 15 Jan 2002 12:24:28 -0500
Received: from vitelus.com ([64.81.243.207]:56846 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S289989AbSAORYP>;
	Tue, 15 Jan 2002 12:24:15 -0500
Date: Tue, 15 Jan 2002 09:24:13 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020115172413.GD7030@vitelus.com>
In-Reply-To: <20020114131050.E14747@thyrsus.com> <Pine.LNX.4.40.0201141045130.22904-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201141045130.22904-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 10:50:20AM -0800, David Lang wrote:
> I can see a couple reasons for building a kernel without useing modules.

I agree with all of yours. IMHO, the proposed scheme for 2.5 is plain
bad. It will require an initrd (initramfs, or whatever), and force
kernel installation to be more difficult. The performance overhead
sounds like a major downside, epsecially when currently people know
what hardware they have and build things into the kernel accordingly.

Between this and CML2, my mental image of 2.5+ is starting to look
very grim.
