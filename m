Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281552AbRLFPJX>; Thu, 6 Dec 2001 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284204AbRLFPJO>; Thu, 6 Dec 2001 10:09:14 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:13723 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S284122AbRLFPJC>;
	Thu, 6 Dec 2001 10:09:02 -0500
Message-ID: <3C0F8A5E.6060501@stesmi.com>
Date: Thu, 06 Dec 2001 16:10:22 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Erik Elmore <lk@bigsexymo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NVIDIA kernel module
In-Reply-To: <Pine.LNX.4.33.0112051719260.13083-100000@erik.bigsexymo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Elmore wrote:

> Have I lost my mind?
> 
> I've always thought that NVIDIA's linux kernel support was incredibly 
> closed source, but I swear I just saw a download link for the kernel 
> module sources at http://www.nvidia.com/view.asp?PAGE=linux
> 
> was I mistaken or is this something new?

You're mistaken.

NVidia releases a binary module with open-source glue-code. You can 
recompile the glue but not the binary part. Same as always

// Stefan


