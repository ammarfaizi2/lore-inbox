Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHYcSZ0SnNXbScK3+oWQ9NJF8Q==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 12:36:04 +0000
Message-ID: <01d701c415a4$761c1bf0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:42:37 +0100
From: "Tomas Szepe" <szepe@pinerecords.com>
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
To: <Administrator@smtp.paston.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Pentium M config option for 2.6
References: <200401041227.i04CReNI004912@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <200401041227.i04CReNI004912@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:38.0046 (UTC) FILETIME=[7684EFE0:01C415A4]

On Jan-04 2004, Sun, 13:27 +0100
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> IOW, don't lie to the compiler and pretend P-M == P4
> with that -march=pentium4.

What do you recommend to use as march then?  There is
no pentiumm subarch support in gcc yet;  I was convinced
p4 was the closest match.

-- 
Tomas Szepe <szepe@pinerecords.com>
