Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbRDNP7d>; Sat, 14 Apr 2001 11:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132473AbRDNP7Y>; Sat, 14 Apr 2001 11:59:24 -0400
Received: from mercury.mv.net ([199.125.85.40]:21772 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S132471AbRDNP7S>;
	Sat, 14 Apr 2001 11:59:18 -0400
Message-ID: <002601c0c4fb$c7e54260$0201a8c0@home>
From: "jeff millar" <jeff@wa1hco.mv.com>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200104140317.f3E3Hv805992@snark.thyrsus.com> <20010414150421.A28066@l-t.ee>
Subject: Re: comments on CML 1.1.0
Date: Sat, 14 Apr 2001 11:58:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting IP_NF_COMPAT_IPCHAINS turns off IP_NF_CONNTRACK and friends.  But,
I think CML1, allowed both support to the new iptables and compatibility
modes to allow old ipchains scripts to work with the new kernel.

jeff

