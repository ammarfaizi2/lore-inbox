Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288827AbSA3HyD>; Wed, 30 Jan 2002 02:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288811AbSA3Hxz>; Wed, 30 Jan 2002 02:53:55 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:30094 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288850AbSA3Hxq>;
	Wed, 30 Jan 2002 02:53:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 08:58:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201300136430.25123-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0201300136430.25123-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Vpde-0000Cp-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 08:41 am, Oliver Xymoron wrote:
> On Tue, 29 Jan 2002, Daniel Phillips wrote:
> 
> > Exactly.  The successor patch to the 'kind of gross' patch got rid of the
> > double-pointers, it was the proper fix, though there is still no excuse for
> > leaving the bug hanging around while coming up with the better version.
> 
> The gross fixes tend to get dropped because if they're in, the proper fix
> loses priority. FIXMEs can take many years to fix. The problem seems not
> to be the dropping of the patch so much as the dropping of the bug report
> and bug tracking is an altogether different problem.

The problem was the dropping of the patch.  A bunch of things contributed
to it, and at this point I believe the main one was having no patch
submission system.  I should know, I was on the dirty end of this stick.

-- 
Daniel
