Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282943AbRLDJRf>; Tue, 4 Dec 2001 04:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282940AbRLDJR0>; Tue, 4 Dec 2001 04:17:26 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17119 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S282948AbRLDJRM>;
	Tue, 4 Dec 2001 04:17:12 -0500
Message-ID: <3C0C93DB.2040909@stesmi.com>
Date: Tue, 04 Dec 2001 10:14:03 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell Mellon <mellonr@hobart.k12.in.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: IP address 10.1.1.0/16 not valid
In-Reply-To: <PDEDJCHJOFMEOMMKOPDGOECJCLAA.mellonr@hobart.k12.in.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Mellon wrote:

> Why is it that the kernel seems to reject using the address 10.1.1.0 on a
> 255.255.0.0 netmask.  That address isn't the broadcast address, 10.1.0.0 is.


To be pendantic, 10.1.0.0 is the network address and 10.1.255.255 is the 
broadcast :)

// Stefan


