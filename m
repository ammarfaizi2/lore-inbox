Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbRJAQ7b>; Mon, 1 Oct 2001 12:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275288AbRJAQ7V>; Mon, 1 Oct 2001 12:59:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52874 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275270AbRJAQ7I>; Mon, 1 Oct 2001 12:59:08 -0400
Date: Mon, 01 Oct 2001 10:07:11 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: John Alvord <jalvo@mbay.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel changes
Message-ID: <1203451613.1001930831@[10.10.1.2]>
In-Reply-To: <Pine.LNX.4.20.0109290937510.18362-100000@otter.mbay.net>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, September 29, 2001 09:45 AM -0700 John Alvord 
<jalvo@mbay.net> wrote:
> ...
> Without a success criteria, this process cannot end.
>
> Other examples are recent updates for multi-quad NUMA machines

I'm not sure why these bother you - if you don't turn on
CONFIG_MULTIQUAD, the code impact is practically non-existant.

Martin.

