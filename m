Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSJVUmO>; Tue, 22 Oct 2002 16:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264948AbSJVUmO>; Tue, 22 Oct 2002 16:42:14 -0400
Received: from trillium-hollow.org ([209.180.166.89]:32142 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S264943AbSJVUmN>; Tue, 22 Oct 2002 16:42:13 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I386 cli 
In-Reply-To: Your message of "Tue, 22 Oct 2002 13:08:43 PDT."
             <E1845KV-0002ab-00@trillium-hollow.org> 
Date: Tue, 22 Oct 2002 13:48:22 -0700
From: erich@uruk.org
Message-Id: <E1845ws-0002g9-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


erich@uruk.org wrote:

> David Grothe <dave@gcom.com> wrote:
> 
> > In 2.5.41every architecture except Intel 386 has a "#define cli 
> > <something>" in its asm-arch/system.h file.  Is there supposed to be such a 
> > define in asm-i386/system.h?  If not, where does the "official" definition 
> > of cli() live for Intel?  Or what is the include file that one needs to 
> > pick it up?  I can't find it.
> 
> I'm sure there is no definition because "cli" is the native assembler
> instruction on x86.

Whoops, foot-in-mouth...  those were C level definitions, not assembler
macros.

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
