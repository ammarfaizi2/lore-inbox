Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289824AbSBEWO0>; Tue, 5 Feb 2002 17:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289826AbSBEWOQ>; Tue, 5 Feb 2002 17:14:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28934 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289824AbSBEWOC>; Tue, 5 Feb 2002 17:14:02 -0500
Message-ID: <3C605910.6060907@zytor.com>
Date: Tue, 05 Feb 2002 14:13:36 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <2006875340.1012946564@[195.224.237.69]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:

> 
> I would be surprised if there is anyone on this list
> who has not lost at some point either the .config, the
> kysms, or something similar associated with at least
> one build they've made.
> 


Sure.  And people have lost their root filesystems due to "rm -rf /".
That doesn't mean we build the entire (real) root filesystem into the kernel.

	-hpa


