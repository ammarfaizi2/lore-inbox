Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293684AbSCFRAW>; Wed, 6 Mar 2002 12:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293689AbSCFRAN>; Wed, 6 Mar 2002 12:00:13 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:55549 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S293684AbSCFRAB>; Wed, 6 Mar 2002 12:00:01 -0500
From: <benh@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
Date: Wed, 6 Mar 2002 18:00:09 +0100
Message-Id: <20020306170009.18038@mailhost.mipsys.com>
In-Reply-To: <3C85F872.7050306@evision-ventures.com>
In-Reply-To: <3C85F872.7050306@evision-ventures.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>3. Someone had too much time at apple, becouse the C++ found
>    there doesn't apparently contain anything that couldn't
>    be expressed without any pain in plain C with structs containing
>    function pointers ;-).

Hehe, right :) Though they actually limit the C++ usage in the kernel
to a kind of "embedded C++", that is without multiple inheritance, RTTI
or exceptions. C++ is the main reason why I call it "bloated".

Ben.


