Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267725AbTAIAqS>; Wed, 8 Jan 2003 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267729AbTAIAqS>; Wed, 8 Jan 2003 19:46:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64651
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267725AbTAIAqR>; Wed, 8 Jan 2003 19:46:17 -0500
Subject: Re: 2.4.21-pre2 Oops in i810_audio.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick McHardy <kaber@trash.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212310315020.20422-200000@el-zoido.localnet>
References: <Pine.LNX.4.44.0212310315020.20422-200000@el-zoido.localnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042076430.25607.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 01:40:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-31 at 02:21, Patrick McHardy wrote:
> based on reading AC97_RESET. Could it be that it is a combined codec and
> it would be perfectly legal not to skip it, even though it includes a
> softmodem ?  I've attached the output of lspci -vv incase its useful.

I do wonder. Its a pita that the ac97 rules seem to change each point release
too.

