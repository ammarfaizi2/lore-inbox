Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266719AbUBMHDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 02:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266784AbUBMHDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 02:03:40 -0500
Received: from dsl-082-083-130-200.arcor-ip.net ([82.83.130.200]:23169 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S266719AbUBMHDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 02:03:39 -0500
Date: Fri, 13 Feb 2004 08:03:34 +0100
From: Dominik Kubla <dominik@kubla.de>
To: Emmeran Seehuber <rototor@rototor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Message-ID: <20040213070333.GA1555@intern.kubla.de>
References: <200402112344.23378.rototor@rototor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402112344.23378.rototor@rototor.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 11:44:23PM +0000, Emmeran Seehuber wrote:
> Hello everybody!
> 
> I'm trying to switch my laptop from kernel 2.4 to kernel 2.6.2. Everything 
> seems to work correctly, only my PS/2 mouse doesn't.

Seconded. After update from 2.6.0 to 2.6.2 both the built-in touchpad and
stick stopped working. XFree86 complained about "no such device" (or something
similiar) when accessing /dev/psaux. /dev/input/mice is also configured but
seems not to work.

Hardware is a Dell Inspiron 8000.

Regards,
  Dominik
-- 
disbar, n:
	As distinguished from some other bar.
