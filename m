Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTJaB50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 20:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTJaB50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 20:57:26 -0500
Received: from tantale.fifi.org ([216.27.190.146]:41859 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262725AbTJaB5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 20:57:25 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Things that Longhorn seems to be doing right
References: <LUlv.31e.5@gated-at.bofh.it> <M7iG.41B.7@gated-at.bofh.it>
	<MagC.82U.7@gated-at.bofh.it> <Maqe.8l3.9@gated-at.bofh.it>
	<3FA0F1B7.7000409@softhome.net>
	<Pine.LNX.4.58.0310301007340.11170@sm1420.belits.com>
	<3FA1BF06.ED00123C@smart.net>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 30 Oct 2003 17:57:24 -0800
In-Reply-To: <3FA1BF06.ED00123C@smart.net>
Message-ID: <87fzhamanv.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Daniel B." <dsb@smart.net> writes:

> Alex Belits wrote:
> > 
> > On Thu, 30 Oct 2003, Ihar 'Philips' Filipau wrote:
> > 
> ...
> > 
> > 3. Pluggable directory generator -- a userspace process can tell the
> > system to make an object that looks exactly like a directory, except that
> > its contents are provided by the process, that is being queried when the
> > directory is accessed.
> 
> That sounds like ClearCase's dynamically generated views of directories
> and files.

Or hurd's translators.

Phil.
