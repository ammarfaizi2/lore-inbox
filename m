Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSGQSF5>; Wed, 17 Jul 2002 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSGQSF4>; Wed, 17 Jul 2002 14:05:56 -0400
Received: from dsl-213-023-052-194.arcor-ip.net ([213.23.52.194]:47047 "EHLO
	duron.intern.kubla.de") by vger.kernel.org with ESMTP
	id <S316535AbSGQSF4>; Wed, 17 Jul 2002 14:05:56 -0400
Date: Wed, 17 Jul 2002 20:08:54 +0200
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: "Jack F. Vogel" <jfv@bluesong.NET>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac7
Message-ID: <20020717180854.GA21075@duron.intern.kubla.de>
References: <200207171056.g6HAuXR24678@devserv.devel.redhat.com> <20020717114605.GA12575@duron.intern.kubla.de> <200207171014.58760.jfv@bluesong.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207171014.58760.jfv@bluesong.net>
User-Agent: Mutt/1.4i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 10:14:58AM -0700, Jack F. Vogel wrote:
> 
> Ran into this on ac6 also, its just a matter of doing a `make mrproper` 
> and redo depends.
> 

Yes, that was the problem. Funny, i thought i had done that...

Dominik Kubla
-- 
UFO is a SIG at the University of Mainz. Meetings are every odd monday of
the month in the workstation laboratory (Zentrum fuer Datenverarbeitung).
We are a Unix derivate independent group.  Every flavor of Unix is welcome.
