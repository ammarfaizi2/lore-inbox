Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSFFUDB>; Thu, 6 Jun 2002 16:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317168AbSFFUDA>; Thu, 6 Jun 2002 16:03:00 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:24480 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317117AbSFFUDA>; Thu, 6 Jun 2002 16:03:00 -0400
Date: Thu, 6 Jun 2002 15:02:42 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixdep fails to use all components in config entry
In-Reply-To: <20020606213934.A16062@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0206061501170.31896-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Sam Ravnborg wrote:

> fixdep, when adding dependencies to config entires fails to take into account
> the last part of a config entry, if it contains more than one underscore.

Doh, you're right. Applied ;-)

--Kai


