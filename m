Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSHIOGI>; Fri, 9 Aug 2002 10:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSHIOGI>; Fri, 9 Aug 2002 10:06:08 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:56715 "EHLO
	starship") by vger.kernel.org with ESMTP id <S312558AbSHIOGI>;
	Fri, 9 Aug 2002 10:06:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: fix CONFIG_HIGHPTE
Date: Fri, 9 Aug 2002 16:10:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Anton Blanchard <anton@samba.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, riel@surriel.com
References: <20020806231522.GJ6256@holomorphy.com> <3D508C83.3A78CC58@zip.com.au> <20020807204332.B5777@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020807204332.B5777@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dASy-0001Mu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 August 2002 20:43, Ingo Oeser wrote:
> On Tue, Aug 06, 2002 at 07:57:07PM -0700, Andrew Morton wrote:
> > - We'll continue to suck for the University workload.
> 
> Hop that's not an 2.6 option, because our University alone is
> using Linux on 1000+ machines, on 500+ private machines and lots
> of mission critical servers.

Bill's university workload consists of 10,000 students logged into *one 
machine*.  I don't think you have to worry about that just now.

-- 
Daniel
