Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280806AbRKBThs>; Fri, 2 Nov 2001 14:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280807AbRKBThi>; Fri, 2 Nov 2001 14:37:38 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:50153 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280806AbRKBTh1>; Fri, 2 Nov 2001 14:37:27 -0500
Date: Fri, 2 Nov 2001 14:37:27 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ian Stirling <root@mauve.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Diagnosing dead mice.
Message-ID: <20011102143726.B4309@redhat.com>
In-Reply-To: <200111021921.TAA00792@mauve.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111021921.TAA00792@mauve.demon.co.uk>; from root@mauve.demon.co.uk on Fri, Nov 02, 2001 at 07:21:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 07:21:18PM +0000, Ian Stirling wrote:
> I've recently bought a new PS/2 scrolmouse, for the princely sum of $2.
> 
> It doesn't work when plugged into my laptop, and occasionally 
> generates "unknown scancode" and random keys when used.

Sounds like the mouse may be working.  Double check that your laptop's 
BIOS is a recent version as most of the laptops I poked at when looking 
into the keyboard driver intercept all keystrokes and mouse movements 
in an attempt to provide additional features.

		-ben
