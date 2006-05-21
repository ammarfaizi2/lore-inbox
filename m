Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWEUXvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWEUXvy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbWEUXvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:51:54 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:7595 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964949AbWEUXvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:51:53 -0400
Date: Sun, 21 May 2006 16:51:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       Ulrich Drepper <drepper@gmail.com>, dragoran <dragoran@feuerpokemon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521235150.GA7581@taniwha.stupidest.org>
References: <44702650.30507@feuerpokemon.de> <200605220019.08902.ak@suse.de> <20060521222831.GP8250@redhat.com> <200605220037.58286.ak@suse.de> <20060521234821.GQ8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521234821.GQ8250@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 07:48:21PM -0400, Dave Jones wrote:

> If a regular user can trip up debugging printks, yes, lets remove it.
> Examples ?

segfaults are printk reported on iamd64 machines, you can fork a lot
of those if you wanted

