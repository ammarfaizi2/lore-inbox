Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpLRjNX3NKJYWThKrZF0BZIlpVg==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 13:18:13 +0000
Message-ID: <030201c415a4$b4658b30$d100000a@sbs2003.local>
Content-Class: urn:content-classes:message
Date: Mon, 29 Mar 2004 16:44:21 +0100
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Paul Jackson" <pj@sgi.com>
To: <Administrator@osdl.org>
Cc: <ak@muc.de>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
In-Reply-To: <20040105014122.GW10569@fs.tum.de>
References: <19ahq-7Rg-11@gated-at.bofh.it><19eEs-5lC-15@gated-at.bofh.it><19kgS-4HT-19@gated-at.bofh.it><m3pte3i17t.fsf@averell.firstfloor.org><20040105014122.GW10569@fs.tum.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:44:22.0125 (UTC) FILETIME=[B48E21D0:01C415A4]

> It was a bug in some _prerelease_ versions of gcc 3.3 SuSE decided to 
> ship in a release of their distribution.

That matches my observations, as I noted an earlier reply on lkml,
when I recommended against accepting my own patch, on the grounds
that we shouldn't pollute the Makefile with exceptions that only
applied to people running the gcc in a particular SuSE distro.

Good.  Thanks for the confirmation.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
