Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRC0Hbd>; Tue, 27 Mar 2001 02:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRC0HbX>; Tue, 27 Mar 2001 02:31:23 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:44043 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S130733AbRC0HbL>; Tue, 27 Mar 2001 02:31:11 -0500
Date: Mon, 26 Mar 2001 23:30:01 -0800
To: Tim Waugh <twaugh@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: paride error, aparantly with VFS
Message-ID: <20010326233001.B4520@ferret.phonewave.net>
In-Reply-To: <20010325213738.A18626@ferret.phonewave.net> <20010326191011.I11451@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010326191011.I11451@redhat.com>; from twaugh@redhat.com on Mon, Mar 26, 2001 at 07:10:11PM +0100
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 07:10:11PM +0100, Tim Waugh wrote:
> On Sun, Mar 25, 2001 at 09:37:38PM -0800, idalton@ferret.phonewave.net wrote:
> 
> > do_pd_read_drq: status = 0x10050 = SEEK READY TMO
> 
> Please try a recent -ac kernel and let me know if the problem persists
> or goes away.

ac25 appears to have this problem fixed.

Still got bit by the OOPS problem in my other post when I tried to
switch drives in the box, though.

-- Ferret
