Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290838AbSAaCgz>; Wed, 30 Jan 2002 21:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290840AbSAaCgk>; Wed, 30 Jan 2002 21:36:40 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:38296 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290838AbSAaCfz>;
	Wed, 30 Jan 2002 21:35:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, landley@trommello.org,
        "Matthew D. Pitts" <mpitts@suite224.net>,
        "Chris Ricker" <kaboom@gatech.edu>,
        "Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Thu, 31 Jan 2002 03:39:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "World Domination Now!" <linux-kernel@vger.kernel.org>
In-Reply-To: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200201302239.QAA39272@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16W783-0000KD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 11:39 pm, Jesse Pollard wrote:
> Linus has announced who he accepts patches frin, and who will be doing the
> 2.0, 2.2, and 2.4 maintenance. It would seem logical to have those 
> lieutenants announce their maintainers.

Logical flaw: Marcelo is the maintainer of 2.4, Linus is the maintainer of 
2.5, does it make sense for Marcelo to announce the maintainer of usb for
2.4?

It's not as simple as you'd think.  Reason: it's not a tree, it's an
acyclic graph.  Hopefully.  ;-)

-- 
Daniel
