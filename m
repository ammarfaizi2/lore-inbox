Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQKNLMi>; Tue, 14 Nov 2000 06:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQKNLM2>; Tue, 14 Nov 2000 06:12:28 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:16907 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129324AbQKNLMW>;
	Tue, 14 Nov 2000 06:12:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel <linux-kernel@i405.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: newbie, 2.4.0-test11-pre4 no compile when CONFIG_AGP=y 
In-Reply-To: Your message of "Tue, 14 Nov 2000 00:56:13 -0800."
             <0066CB04D783714B88D83397CCBCA0CD495F@spike2.i405.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2000 21:42:16 +1100
Message-ID: <1779.974198536@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000 00:56:13 -0800, 
linux-kernel <linux-kernel@i405.com> wrote:
>I'll preface this saying I'm a kernel compile newbie and I could be making
>the most basic of mistakes.

You are.  Hand editing the .config file gives undefined results.  Make
all changes through menuconfig or xconfig.  The config system does lots
of work behind the scenes which is not peformed if you hand edit.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
