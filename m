Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHYsaE/NwDq1Sx+8yKOpD27qoQ==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 13:07:15 +0000
Message-ID: <01eb01c415a4$762cbdc0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Date: Mon, 29 Mar 2004 16:42:37 +0100
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Thomas Molina" <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: <Administrator@smtp.paston.co.uk>
Cc: "Andrew Morton" <akpm@osdl.org>
Subject: Re: make modules_install problem in 2.6.0-rc1-mm1
In-Reply-To: <Pine.LNX.4.58.0401040749180.11783@localhost.localdomain>
References: <Pine.LNX.4.58.0401040749180.11783@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:38.0578 (UTC) FILETIME=[76D61D20:01C415A4]

On Sun, 4 Jan 2004, Thomas Molina wrote:

> I get the following message when compiling profile suport into 
> 2.6.0-rc1-mm1:
> 
> WARNING: /lib/modules/2.6.1-rc1-mm1/kernel/arch/i386/oprofile/oprofile.ko needs unknown symbol cpu_possible
> 
> My .config file is attached.

Sorry about that.  The Subject should obviously refer to 2.6.1-rc1-mm1, 
not 2.6.0.
