Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261657AbSJVUEq>; Tue, 22 Oct 2002 16:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSJVUEq>; Tue, 22 Oct 2002 16:04:46 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:29341 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261657AbSJVUEo>;
	Tue, 22 Oct 2002 16:04:44 -0400
Date: Tue, 22 Oct 2002 22:10:41 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Grothe <dave@gcom.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I386 cli
Message-ID: <20021022221041.A25152@ucw.cz>
References: <5.1.0.14.2.20021022145759.02861ec8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20021022145759.02861ec8@localhost>; from dave@gcom.com on Tue, Oct 22, 2002 at 03:01:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 03:01:47PM -0500, David Grothe wrote:
> In 2.5.41every architecture except Intel 386 has a "#define cli 
> <something>" in its asm-arch/system.h file.  Is there supposed to be such a 
> define in asm-i386/system.h?  If not, where does the "official" definition 
> of cli() live for Intel?  Or what is the include file that one needs to 
> pick it up?  I can't find it.

cli() is dead.

-- 
Vojtech Pavlik
SuSE Labs
