Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTAATT5>; Wed, 1 Jan 2003 14:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTAATT5>; Wed, 1 Jan 2003 14:19:57 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:56330 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S261529AbTAATT5>;
	Wed, 1 Jan 2003 14:19:57 -0500
To: John Bradford <john@grabjohn.com>
Cc: jochen@scram.de (Jochen Friedrich), xavier.bestel@free.fr,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
References: <200212311431.gBVEVLVB001666@darkstar.example.net>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 01 Jan 2003 20:28:15 +0100
In-Reply-To: John Bradford's message of "Tue, 31 Dec 2002 14:31:21 +0000 (GMT)"
Message-ID: <yw1x7kdozn3k.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> > Alpha works around this by using an X86 emulator in their PAL code.
> 
> That's interesting, I didn't know that.  How complete is it?  Does it
> just emulate a subset of X86 instructions that are enough for 90% of
> initialisation code?

AFAIK it only emulates 16-bit real mode, which is what the bios code
is.  I've never seen a card that failed to work because of this.

-- 
Måns Rullgård
mru@users.sf.net
