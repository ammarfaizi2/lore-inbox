Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUAUVzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUAUVzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:55:19 -0500
Received: from 101.24.177.216.inaddr.g4.Net ([216.177.24.101]:53948 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP id S266094AbUAUVzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:55:07 -0500
Date: Wed, 21 Jan 2004 16:55:04 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Esben Stien <executiv@online.no>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: logging all input and output on a tty
In-Reply-To: <87ad4h5juk.fsf@online.no>
Message-ID: <Pine.LNX.4.44.0401211651130.2713-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoom, Esben,

On 21 Jan 2004, Esben Stien wrote:

> I've been trying to get an answer to tty logging for a long time without
> anyone able to answer. I want to log everything that is written to and
> from a certain tty. I expect this to be a kernel module. Anyone have any
> pointers where I can look?. Is there an existing module?

	User-Mode Linux can log all traffic to or from a tty to files 
stored on the host.
	http://user-mode-linux.sourceforge.net/tty_logging.html

	Any questions about this feature should be directed to: 
User-mode-linux-user@lists.sourceforge.net
	Cheers,
	- Bill

---------------------------------------------------------------------------
	How's my programming?  Call 1-800-DEV-NULL
(Courtesy of http://www.tux.org/~ricdude/)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

