Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314686AbSEUPFs>; Tue, 21 May 2002 11:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314694AbSEUPFr>; Tue, 21 May 2002 11:05:47 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:20204 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314686AbSEUPFq>; Tue, 21 May 2002 11:05:46 -0400
Date: Tue, 21 May 2002 08:05:19 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Brian Gerst <bgerst@didntduck.org>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpu_has_tsc
Message-ID: <1314666991.1021968318@[10.10.2.3]>
In-Reply-To: <3CE9AC93.5050107@didntduck.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent - thanks for doing this. This is obviously broken
at the moment, and I have to disable TSCs ;-)

--On Monday, May 20, 2002 10:10 PM -0400 Brian Gerst <bgerst@didntduck.org> wrote:

> This patch converts drivers/char/random.c and drivers/input/joystick/analog.c to use the cpu_has_tsc macro.
> 
> --
> 
> 						Brian Gerst


