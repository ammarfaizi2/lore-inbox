Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSGLWSB>; Fri, 12 Jul 2002 18:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318034AbSGLWSA>; Fri, 12 Jul 2002 18:18:00 -0400
Received: from fungus.teststation.com ([212.32.186.211]:35076 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S318033AbSGLWR7>; Fri, 12 Jul 2002 18:17:59 -0400
Date: Sat, 13 Jul 2002 00:18:29 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.enlightnet.local
To: Adrian Bunk <bunk@fs.tum.de>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: What is the most stable kernel to date?
In-Reply-To: <Pine.NEB.4.44.0207122350140.24665-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0207130009110.7728-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Adrian Bunk wrote:

> On Fri, 12 Jul 2002, Richard B. Johnson wrote:
> 
> > 2.4.18 doesn't have any 'crashing' bugs in normal use. One of my
> >...
> 
> Perhaps in your "normal use"...
> 
> If you mount SMB shares Oopses appear quite frequently.

2.4.18 oopses if the share has characters that are not in your nls table.
Patched and fixed for 2.4.19 (unless you are talking about some other oops?)

/Urban

