Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUBRKGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUBRKGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:06:10 -0500
Received: from [212.28.208.94] ([212.28.208.94]:27663 "HELO dewire.com")
	by vger.kernel.org with SMTP id S264147AbUBRKGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:06:08 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: tridge@samba.org
Subject: Re: UTF-8 and case-insensitivity
Date: Wed, 18 Feb 2004 11:05:58 +0100
User-Agent: KMail/1.6.1
Cc: hpa@zytor.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <16434.58656.381712.241116@samba.org>
In-Reply-To: <16434.58656.381712.241116@samba.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402181105.58425.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 05.08, tridge@samba.org wrote:
> Hpa,
> 
> > So you're hosed if anyone uses characters outside the UCS-2 character
> > set...
> 
> I've heard they are re-defining all those 16 bit numbers to be UCS-16
> instead of UCS-2 for exactly that reason. This is rather similar to
> the move in the Unix community to start using UTF-8.

I've read it also: http://www.microsoft.com/globaldev/getwr/steps/wrg_unicode.mspx
"The fundamental representation of text in Windows NT-based operating systems is UTF-16"

-- robin
