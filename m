Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313245AbSC1UH1>; Thu, 28 Mar 2002 15:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313244AbSC1UHR>; Thu, 28 Mar 2002 15:07:17 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:24101 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313245AbSC1UHG>;
	Thu, 28 Mar 2002 15:07:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Sebastian Roth <xsebbi@gmx.de>
Reply-To: xsebbi@gmx.de
Message-Id: <200203282052.15527@xsebbi.de>
To: Andrey Klochko <andrey@eccentric.mae.cornell.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.7-dj2] Compile Error
Date: Thu, 28 Mar 2002 21:07:47 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3CA36885.2080800@mae.cornell.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 28. March 2002 20:01, Andrey Klochko wrote:
> Try attached patch

Ok, 2.5.7-dj2 compiles cleanly with your patch, but only if 
CONFIG_BSD_PROCESS_ACCT is not set at .config .

Thank you!

> Andrey

		Sebastian

BTW:
Lilo says that 2.5.7-dj2 is too big!
How that?
Boot sector 512 bytes.
Setup is 4772 bytes.
System is 1011 kB

