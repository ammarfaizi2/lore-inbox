Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318652AbSHVJYF>; Thu, 22 Aug 2002 05:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSHVJYF>; Thu, 22 Aug 2002 05:24:05 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:49150 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S318652AbSHVJYE>; Thu, 22 Aug 2002 05:24:04 -0400
Date: Thu, 22 Aug 2002 10:59:42 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: James Hayhurst <herrdoktor@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot unmount initrd
Message-ID: <20020822105942.A807@linux-m68k.org>
References: <20020822005730.9319.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020822005730.9319.qmail@email.com>; from herrdoktor@email.com on Wed, Aug 21, 2002 at 07:57:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 07:57:30PM -0500, James Hayhurst wrote:
> I'm making a boot CD and having problems unmounting and freeing the initrd after pivoting to a different root.  First off, for some reaosn it seems that /linuxrc is not being executed. 

don't use 'root=/dev/ramX' if you want linuxrc executed.


Richard

