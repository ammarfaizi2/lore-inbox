Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946614AbWKAGeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946614AbWKAGeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946635AbWKAGeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:34:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:9400 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1946614AbWKAGeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:34:17 -0500
Date: Tue, 31 Oct 2006 22:17:41 -0800
From: Greg KH <greg@kroah.com>
To: Sylvain Bertrand <sylvain.bertrand@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <cw@f00f.org>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
Subject: Re: [Bugme-new] [Bug 7437] New: VIA VT8233 seems to suffer from the via latency quirk
Message-ID: <20061101061741.GA25208@kroah.com>
References: <200610310020.k9V0KGQK003237@fire-2.osdl.org> <20061030163458.4fb8cee1.akpm@osdl.org> <d512a4f30610301703r68dfa848s116475b68435f136@mail.gmail.com> <20061031034342.GC11944@kroah.com> <d512a4f30610311755g11054e88w36f35e93205722a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d512a4f30610311755g11054e88w36f35e93205722a7@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 02:55:18AM +0100, Sylvain Bertrand wrote:
> I enabled the via latency quirk code for my chipset and my workstation
> does crash the same way.
> Then, my crash problem seems not related to this quirk even if
> symptoms are quite similar.

Thank you for testing.  Can you try contacting VIA to find out what
needs to be fixed here?
