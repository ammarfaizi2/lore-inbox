Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbSJCUdA>; Thu, 3 Oct 2002 16:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbSJCUdA>; Thu, 3 Oct 2002 16:33:00 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:1427 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261389AbSJCUc7>; Thu, 3 Oct 2002 16:32:59 -0400
Date: Thu, 3 Oct 2002 15:38:22 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: kbuild-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: RfC: Don't cd into subdirs during kbuild
In-Reply-To: <20021003223054.A31484@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0210031536370.24570-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Sam Ravnborg wrote:

> On Thu, Oct 03, 2002 at 10:01:20PM +0200, Sam Ravnborg wrote:
> > Now it's testing time..

[...]

You must be missing some of the changes (My first push to bkbits was 
incomplete, since I did inadvertently edit Makefile without checking it 
out, I do that mistake all the time...). It's fixed in the current repo.

--Kai


