Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUABAwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUABAwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:52:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262050AbUABAwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:52:32 -0500
Date: Fri, 2 Jan 2004 00:52:24 +0000
From: Dave Jones <davej@redhat.com>
To: Tommy Faasen <tommy@zwanebloem.nl>
Cc: linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org
Subject: Re: BUG: 2.6.0 non fatal recoverable errors crash gcc
Message-ID: <20040102005224.GA18361@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tommy Faasen <tommy@zwanebloem.nl>, linux-kernel@vger.kernel.org,
	linux-gcc@vger.kernel.org
References: <3FF4B3E7.9050309@zwanebloem.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF4B3E7.9050309@zwanebloem.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 12:57:27AM +0100, Tommy Faasen wrote:

 > I'm not subscribed to this newsgroup, but i'll try to read the follow-up 
 > messages if any.
 > 
 > When my machine is doing big compiles like the kernel or mythtv , 
 > gcc/g++ crashes.
 > This happens after syslog tell me  that there is a recoverable error 
 > (see output below).
 > This happened several times but I don't know why and what I can do about 
 > it ..
 > The machine seems to be very stable, but it could be a hardware problem 
 > i guess.

It is. MCE's are an early sign of hardware going flaky.
Inadequate power, poor cooling etc can also trigger them.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
