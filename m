Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263675AbRFTL0M>; Wed, 20 Jun 2001 07:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264331AbRFTL0C>; Wed, 20 Jun 2001 07:26:02 -0400
Received: from vitelus.com ([64.81.36.147]:26890 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S263675AbRFTLZt>;
	Wed, 20 Jun 2001 07:25:49 -0400
Date: Wed, 20 Jun 2001 04:25:44 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: [OT] Threads, inelegance, and Java
Message-ID: <20010620042544.E24183@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9gponv$j92$1@forge.intermeta.de>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 09:00:47AM +0000, Henning P. Schmiedehausen wrote:
> Just the fact that some people use Java (or any other language) does
> not mean, that they don't care about "performance, system-design or
> any elegance whatsoever" [2].

However, the very concept of Java encourages not caring about
"performance, system-design or any elegance whatsoever". If you cared
about any of those things you would compile to native code (it exists
for a reason). Need run-anywhere support? Distribute sources instead.
Once they are compiled they won't need to be reinterpreted on every
run.
