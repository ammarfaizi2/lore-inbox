Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278420AbRJMVoO>; Sat, 13 Oct 2001 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278421AbRJMVnz>; Sat, 13 Oct 2001 17:43:55 -0400
Received: from mail.gmx.de ([213.165.64.20]:38979 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S278420AbRJMVnr>;
	Sat, 13 Oct 2001 17:43:47 -0400
Message-ID: <00ea01c15430$345a96c0$303fe33e@host1>
From: "peter k." <spam-goes-to-dev-null@gmx.net>
To: "Aaron Lehmann" <aaronl@vitelus.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <004801c153d6$ffc398c0$0100005a@host1> <20011013135507.B9856@vitelus.com>
Subject: [solved] iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
Date: Sat, 13 Oct 2001 23:44:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 13, 2001 at 01:05:33PM +0200, peter k. wrote:
> > iptables keeps telling me that whenever i run it although i got the
latest
> > kernel, latest iptables and all modules required for iptables are loaded
(it
> > also doesnt work when i compile them into the kernel)!
> > anyone got an idea how to fix this?
>
> did you compile your iptables against the version/configuration of the
> kernel you are trying to run?

did that, now it works! :)
seems like it doesnt work if i use the iptables from the mandrake rpm


