Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276329AbRJPOWw>; Tue, 16 Oct 2001 10:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276330AbRJPOWn>; Tue, 16 Oct 2001 10:22:43 -0400
Received: from [213.237.118.153] ([213.237.118.153]:21632 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S276329AbRJPOWc>;
	Tue, 16 Oct 2001 10:22:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: VM
Date: Tue, 16 Oct 2001 16:19:37 +0200
X-Mailer: KMail [version 1.3]
In-Reply-To: <Pine.LNX.4.40.0110152111280.1380-100000@dlang.diginsite.com> <20011016133402Z276231-17408+990@vger.kernel.org>
In-Reply-To: <20011016133402Z276231-17408+990@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15tV4X-0000PN-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 October 2001 15:34, safemode wrote:
> This is where a complex solution can be better than a simple.  A mix of
> loads means you'll have different Kinds of programs....not just different
> programs, asking the VM for various things.  Because they're different
> kinds of programs they'll benefit from not being treated all under a vague
> reaction that would be given by a simplistic VM.  A simplistic solution may
> be faster in doing what it does, but in the real world time goes on from
> that point and what the VM did before effects what is happening later.  And
> overall a simplistic solution may actually hurt the performance of a VM.
>
A simplistic solution is more predictable, and therefor easier to write 
programs for that run well. This is the same principle that makes modern 
processors fast. We only need to enable any kind of program, not any 
behavior, becouse that behavior might in fact be harmfull or inefficient.

> People who use the latest 2.4.x kernel aren't running critical servers,
> rebooting back to their previous non-Rik vm kernel wont be much of an
> issue. It wont "break" anything, rather just be better or worse performance
> wise. If you can afford to reboot to upgrade to the latest 2.4.x, you can
> afford to reboot to move back to your backup kernel.
>
This sounds more like a pro-Andrea/Linus argument :)

`Allan
