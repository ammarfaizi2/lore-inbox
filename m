Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288759AbSA3Hlx>; Wed, 30 Jan 2002 02:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288761AbSA3Hle>; Wed, 30 Jan 2002 02:41:34 -0500
Received: from waste.org ([209.173.204.2]:15510 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S288759AbSA3HlZ>;
	Wed, 30 Jan 2002 02:41:25 -0500
Date: Wed, 30 Jan 2002 01:41:22 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16VgQ0-0000AS-00@starship.berlin>
Message-ID: <Pine.LNX.4.44.0201300136430.25123-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Daniel Phillips wrote:

> Exactly.  The successor patch to the 'kind of gross' patch got rid of the
> double-pointers, it was the proper fix, though there is still no excuse for
> leaving the bug hanging around while coming up with the better version.

The gross fixes tend to get dropped because if they're in, the proper fix
loses priority. FIXMEs can take many years to fix. The problem seems not
to be the dropping of the patch so much as the dropping of the bug report
and bug tracking is an altogether different problem.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

