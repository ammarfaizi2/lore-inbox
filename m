Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293469AbSCOXMF>; Fri, 15 Mar 2002 18:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293468AbSCOXLp>; Fri, 15 Mar 2002 18:11:45 -0500
Received: from mail.webmaster.com ([216.152.64.131]:8423 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S293466AbSCOXLl> convert rfc822-to-8bit; Fri, 15 Mar 2002 18:11:41 -0500
From: David Schwartz <davids@webmaster.com>
To: <davem@redhat.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Fri, 15 Mar 2002 15:11:39 -0800
In-Reply-To: <20020315.145306.15914579.davem@redhat.com>
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020315231140.AAA28201@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Mar 2002 14:53:06 -0800 (PST), David S. Miller wrote:

>There is no reason to not be doing this MD5 garbage in
>userspace.  Whoever thought to do this in the protocol
>itself was smoking something.

	This same argument would apply to TCP itself, wouldn't it?

>Maybe I'm missing something, but I see no reason this MD5
>stuff belongs in the protocol and not in the APP.

	How can a TCP-using application authenticate a RST?

	DS


