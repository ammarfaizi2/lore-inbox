Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289551AbSA2M3W>; Tue, 29 Jan 2002 07:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289628AbSA2M2D>; Tue, 29 Jan 2002 07:28:03 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:45699 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289589AbSA2M1V>;
	Tue, 29 Jan 2002 07:27:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: <mingo@elte.hu>, Rob Landley <landley@trommello.org>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 13:31:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VXQP-0000A8-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 02:54 pm, Ingo Molnar wrote:
> If a patch gets ignored 33 times in a row then perhaps the person doing
> the patch should first think really hard about the following 4 issues:
> 
>   - cleanliness
>   - concept
>   - timing
>   - testing
> 
> a violation of any of these items can cause patch to be dropped *without
> notice*. Face it, it's not Linus' task to teach people how to code or how
> to write correct patches. Sure, he still does teach people most of the
> time, but you cannot *expect* him to be able to do it 100% of the time.

While I agree in general with most of your remarks, I think you're being a 
little too glib here.  Consider my patch to fix group descriptor corruption 
in Ext2, submitted half a dozen times to Linus and other maintainers over the 
course of two years, which was clearly explained, passed scrutiny on 
ext2-devel and lkml, fixed a real problem that really bit people and which 
I'd been running myself over the entire period.  Which one of cleanliness, 
concept, timing or testing did I violate?

If the answer is 'none of the above', then what is wrong with this picture?

--
Daniel
