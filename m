Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbSLRI0Q>; Wed, 18 Dec 2002 03:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbSLRI0Q>; Wed, 18 Dec 2002 03:26:16 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:7695 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267200AbSLRI0Q>; Wed, 18 Dec 2002 03:26:16 -0500
Date: Wed, 18 Dec 2002 19:34:06 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "Feldman, Scott" <scott.feldman@intel.com>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>,
       LOSTeam <losteam@intel.com>
Subject: Re: [ANNOUNCE] Intel PRO/100 software developer manual released
In-Reply-To: <288F9BF66CD9D5118DF400508B68C44604758F6C@orsmsx113.jf.intel.com>
Message-ID: <Mutt.LNX.4.44.0212181911120.16469-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Feldman, Scott wrote:

> The manual is intended to support the maintenance of the e100 driver (or the
> best driver for the PRO/100 networking hardware ;-).  The manual covers the
> 82557, 82558, 82559, 82550, and 82551 Ethernet controllers.

Hi Scott,

This looks great.  Any chance of releasing documentation on the crypto
hardware which resides on the PRO/100 S?  We're currently looking at
adding support for hardware crypto (including IPsec offload) to the
kernel, and it would be good to include the requirements and capabilities
of this card in the design process.


- James
-- 
James Morris
<jmorris@intercode.com.au>


