Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTDYHzX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 03:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTDYHzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 03:55:23 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:2217 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S263493AbTDYHzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 03:55:22 -0400
Date: Fri, 25 Apr 2003 09:07:25 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Rafal Bujnowski <bujnor@go2.pl>
cc: jds <jds@soltis.cc>, linux-kernel@vger.kernel.org
Subject: Re: Modutils version for kernel 2.5.68-mm ?
In-Reply-To: <20030425093924.3427fab9.bujnor@go2.pl>
Message-ID: <Pine.LNX.4.53.0304250906020.22803@jester.mews>
References: <20030424162406.M94538@soltis.cc> <20030425093924.3427fab9.bujnor@go2.pl>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (198yEt-0005gs-8m)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (198yEw-00060l-Sl)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:39 +0200 Rafal Bujnowski wrote:

>A "jds" <jds@soltis.cc> na to:
>
>>    What is the version modutils for kernel 2.5.68 o 2.5.68-mmx for
>>    RH9.0 and
>
>On my Debian Sid with kernel 2.5.68 I have modutils 2.4.21. And it
>works.

I suspect your modutils has been patched.

jds, just grab modutils-2.4.22-10 or later from rawhide.
