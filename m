Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271295AbRHZIBu>; Sun, 26 Aug 2001 04:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271297AbRHZIBk>; Sun, 26 Aug 2001 04:01:40 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:2287 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S271295AbRHZIBV>; Sun, 26 Aug 2001 04:01:21 -0400
Date: Sun, 26 Aug 2001 09:00:27 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Gregory Ade <gkade@unnerving.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8-ac11 compile error on sparc
In-Reply-To: <Pine.LNX.4.33.0108251424210.15717-100000@tigger.unnerving.org>
Message-ID: <Pine.LNX.4.33.0108260859190.22074-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Gregory Ade wrote:

> as an aside, is there a version of 2.4 that *does* build on a sparc?

2.4.1 was the last one known to build and boot. There are a few problems
with modules in that though, in that these modules won't properly load
because of unresolved externals such as .udiv etc.

-- 
Be careful out there.

http://www.tahallah.demon.co.uk

