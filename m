Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWAWU4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWAWU4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWAWU4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:56:11 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:27784 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1030188AbWAWU4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:56:09 -0500
Date: Mon, 23 Jan 2006 21:56:08 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/04] Add DSA key type
Message-ID: <20060123205608.GA9751@hardeman.nu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060123173208.GA23964@2gen.com> <11380489522362@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11380489522362@2gen.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 09:42:32PM +0100, David Härdeman wrote:
>The following four patches add support for DSA keys to the in-kernel key 
>management system. 
[...]
>1) Adds the multi-precision-integer maths library which was originally taken
>   from GnuPG and ported to the kernel by David Howells in 2004
>   (http://people.redhat.com/~dhowells/modsign/modsign-269rc4mm1-2.diff.bz2)

And in case that patch is caught by any size restrictions, it's also 
available at:
http://www.hardeman.nu/~david/lkml/01-add-mpilib.patch

Re,
David
