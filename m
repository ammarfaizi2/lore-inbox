Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314838AbSD2HQ2>; Mon, 29 Apr 2002 03:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314841AbSD2HQ1>; Mon, 29 Apr 2002 03:16:27 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:39603 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S314838AbSD2HQ0>; Mon, 29 Apr 2002 03:16:26 -0400
Date: Mon, 29 Apr 2002 09:15:39 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Stephan Maciej <stephan@maciej.muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Sony Vaio Laptop problems
Message-ID: <20020429071538.GC2740@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Stephan Maciej <stephan@maciej.muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200204261728.39745.stephan@maciej.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 05:28:39PM +0200, Stephan Maciej wrote:

> The only thing that fixes this problem is loading or installing the sonypi 
> driver into the kernel. It doesn't function as expected, but it solves at 
> least *this* problem. 
[...]

I suppose you load the sonypi driver with the 'fnkeyinit=1' parameter,
right ? In this case, the sonypi mode will enable the ACPI mode
which seems to do the trick for you.

Getting the latest BIOS update from Sony (could be labeled as a
windows XP bios update or something like this) and the latest ACPI
patch from http://acpi.sourceforge.net will almost certainly
help, as other people pointed out.

Once you make your laptop work correctly from a kernel / bios
point of view, you might want to contact me in private to see
if we can get the sonypi driver to work for you.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
