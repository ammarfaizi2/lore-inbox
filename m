Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRBMXFc>; Tue, 13 Feb 2001 18:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbRBMXFW>; Tue, 13 Feb 2001 18:05:22 -0500
Received: from kashiwa7-181.ppp-1.dion.ne.jp ([210.157.147.181]:12037 "EHLO
	ask.ne.jp") by vger.kernel.org with ESMTP id <S129414AbRBMXFD>;
	Tue, 13 Feb 2001 18:05:03 -0500
Date: Wed, 14 Feb 2001 08:04:49 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: James Sutherland <jas88@cam.ac.uk>
Cc: jeremy.jackson@sympatico.ca, linux-kernel@vger.kernel.org
Subject: Re: Is this the ultimate stack-smash fix?
Message-Id: <20010214080449.1faf28e8.bruce@ask.ne.jp>
In-Reply-To: <Pine.SOL.4.21.0102132119530.1900-100000@green.csi.cam.ac.uk>
In-Reply-To: <3A899FEB.D54ABBC7@sympatico.ca>
	<Pine.SOL.4.21.0102132119530.1900-100000@green.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.6; Linux 2.2.18; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001 21:22:26 +0000 (GMT)
James Sutherland <jas88@cam.ac.uk> wrote:

> On Tue, 13 Feb 2001, Jeremy Jackson wrote:
> 
> (Long description of how to create a non-executable stack on x86)
>
> ISTR there is a patch which does this for Linux, though??

See:

 http://www.openwall.com/linux/

for Solar Designer's patch, and:

 http://www.insecure.org/sploits/non-executable.stack.problems.html

for the exploit. It was done to death on the linux-security ML a while
ago, so you could search the archives if you want to know more.

--
Bruce Harada
bruce@ask.ne.jp

