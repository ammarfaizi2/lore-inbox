Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315792AbSFUCpx>; Thu, 20 Jun 2002 22:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSFUCpw>; Thu, 20 Jun 2002 22:45:52 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:54752 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315792AbSFUCpw>; Thu, 20 Jun 2002 22:45:52 -0400
Date: Thu, 20 Jun 2002 21:45:53 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.24 : net/802/cl2llc.c patch rejected
In-Reply-To: <3D126B38.5010202@si.rr.com>
Message-ID: <Pine.LNX.4.44.0206202144570.30897-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Frank Davis wrote:

>      I just patched to 2.5.24 from 2.5.23 and the patch for 
> net/802/cl2llc.c was rejected (file already existed).

The file is supposed to be removed by that patch. Did you call patch 
with -p1 from within your src tree?

--Kai


