Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpAfzldBTQDMrTNS3jP7ufu+Jaw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 03:11:05 +0000
Message-ID: <007e01c415a4$07f3e220$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
From: "Rusty Russell" <rusty@rustcorp.com.au>
To: <Administrator@osdl.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
        <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
In-Reply-To: Your message of "Fri, 02 Jan 2004 08:58:09 -0800."             <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> 
Date: Mon, 29 Mar 2004 16:39:32 +0100
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:32.0750 (UTC) FILETIME=[081302E0:01C415A4]

In message <Pine.LNX.4.44.0401020856150.2278-100000@bigblue.dev.mdolabs.com> you write:
> Rusty, you still have to use global static data when there is no need.

And you're still putting obscure crap in the task struct when there's
no need.  Honestly, I'd be ashamed to post such a patch.

> I like this version better though ;)

I think I should seek a second opinion though.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
