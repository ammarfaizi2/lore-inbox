Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSFXAPT>; Sun, 23 Jun 2002 20:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317211AbSFXAPS>; Sun, 23 Jun 2002 20:15:18 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:27776 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317209AbSFXAPS>; Sun, 23 Jun 2002 20:15:18 -0400
Date: Sun, 23 Jun 2002 19:15:17 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rudmer van Dijk <rvandijk@science.uva.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild fixes and more
In-Reply-To: <20020623205939Z317140-22020+9329@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0206231913170.24916-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Rudmer van Dijk wrote:

> got this error while patching (against 2.5.24 tarball):

Hmmh, it seems all three errors you get are related to the same problem: I 
don't know the proper command how to create a gnu patch from my bk tree.

Anyway, so now there's a version 3 which I diffed manually. Still has the
warning for "make clean", but should work.

(I couldn't help but wonder: Is three tries enough to get it right?)

--Kai

