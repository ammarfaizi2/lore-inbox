Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266493AbRGDDgX>; Tue, 3 Jul 2001 23:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266495AbRGDDgN>; Tue, 3 Jul 2001 23:36:13 -0400
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:64896 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S266493AbRGDDgI>;
	Tue, 3 Jul 2001 23:36:08 -0400
Date: Tue, 3 Jul 2001 23:36:05 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010703233605.A1244@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200107040337.XAA00376@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200107040337.XAA00376@smarty.smart.net>; from humbubba@smarty.smart.net on Tue, Jul 03, 2001 at 11:37:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 11:37:28PM -0400, Rick Hohensee wrote:
> In other words, if you know the push sequence of your C compiler's
> function calls, you don't need asm("");.

You are very much forgetting _inline_ asm.  And if you think that's
unimportant for performance, well, as Al would say, go back playing
with Hurd.

  OG.

