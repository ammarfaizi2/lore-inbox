Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSGRQcV>; Thu, 18 Jul 2002 12:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318275AbSGRQcK>; Thu, 18 Jul 2002 12:32:10 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:8441 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S318274AbSGRQcJ>; Thu, 18 Jul 2002 12:32:09 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1027009764.3d36ece430d75@www.mailshell.com> 
References: <1027009764.3d36ece430d75@www.mailshell.com> 
To: linux@davidtrott.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PPP_DEFLATE and CONFIG_ZLIB_FS_INFLATE cannot both be compiled directly into the kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Jul 2002 17:35:08 +0100
Message-ID: <14518.1027010108@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linux@davidtrott.com said:
> [1.] One line summary of the problem:
> CONFIG_PPP_DEFLATE and CONFIG_ZLIB_FS_INFLATE cannot both be compiled
> directly into the kernel. 

ftp://ftp.??.kernel.org/pub/linux/kernel/people/dwmw2/shared-zlib/

It'll be submitted to Marcelo for 2.4.20-pre1.

--
dwmw2


