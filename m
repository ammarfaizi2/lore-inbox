Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTLVVSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTLVVSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:18:30 -0500
Received: from pri-dns1.mtco.com ([207.179.200.251]:48353 "HELO
	pri-dns1.mtco.com") by vger.kernel.org with SMTP id S264510AbTLVVS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:18:29 -0500
From: Tom Felker <tcfelker@mtco.com>
To: Stan Bubrouski <stan@ccs.neu.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SCO's infringing files list
Date: Mon, 22 Dec 2003 15:19:04 -0600
User-Agent: KMail/1.5.4
References: <1072125736.1286.170.camel@duergar>
In-Reply-To: <1072125736.1286.170.camel@duergar>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312221519.04677.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 December 2003 2:42 pm, Stan Bubrouski wrote:
> Guys,
>
> According to the totally inept, idiotic, SCO group, these files are
> copyrighted by them (and recently by Novell I might add):

> include/asm-i386/errno.h

> Any thoughts?
>
> -sb

The original errno.h, from linux-0.01, says it was taken from minix, and goes 
up to 40.  Between linux-0.96c and linux-0.97, that file was replaced with 
the present version, which includes the error strings and goes up to 121.

Where did the 0.97 to present version come from?

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

Everything else about computers has become cheaper and faster.  Why
not software?

