Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbTCMMQJ>; Thu, 13 Mar 2003 07:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbTCMMQJ>; Thu, 13 Mar 2003 07:16:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43213
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262258AbTCMMQI>; Thu, 13 Mar 2003 07:16:08 -0500
Subject: Re: support for/detection of  new VIA C3 core
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mathias Kretschmer <mathias@lemur.sytes.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E70086B.6080408@lemur.sytes.net>
References: <3E70086B.6080408@lemur.sytes.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047562505.25948.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 13 Mar 2003 13:35:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 04:26, Mathias Kretschmer wrote:
> Hi,
> 
> Are there any plans to supports this new CPU core in 2.4 ?
> i.e. it now supports SSE and no longer 3dnow (as reported
> by the kernel).

The kernel is reporting correctly, and it reads the data from
the CPU. You have a 1GHz Ezra not a Nemiah

