Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbRFAEre>; Fri, 1 Jun 2001 00:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263374AbRFAErY>; Fri, 1 Jun 2001 00:47:24 -0400
Received: from mail.inconnect.com ([209.140.64.7]:705 "HELO mail.inconnect.com")
	by vger.kernel.org with SMTP id <S263372AbRFAErN>;
	Fri, 1 Jun 2001 00:47:13 -0400
Date: Thu, 31 May 2001 22:47:11 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
To: Tim Hockin <thockin@sun.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real
 this  time)
In-Reply-To: <3B1702AB.89C0790F@sun.com>
Message-ID: <Pine.SOL.4.30.0105312241120.6722-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin said once upon a time (Thu, 31 May 2001):

> Aattached is a (large, but self contained) patch for Cobalt Networks suport
> for x86 systems (RaQ3, RaQ4, Qube3, RaQXTR).  Please let me know if there
> is anything that would prevent this from general inclusion in the next
> release.

I can vouch for these patches stability wise.  I've been running an
earlier version of these patches (for 2.4.4) on a Qube 3 acting as a
firewall for 3 weeks without any problems.

Incidently, that Qube 3 is running Red Hat 7.1 and using reiserfs on all
filesystems except for /boot.

Dax

