Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263377AbSJOIoQ>; Tue, 15 Oct 2002 04:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263438AbSJOIoP>; Tue, 15 Oct 2002 04:44:15 -0400
Received: from k100-128.bas1.dbn.dublin.eircom.net ([159.134.100.128]:14864
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S263377AbSJOIoP>; Tue, 15 Oct 2002 04:44:15 -0400
Message-ID: <3DABD66B.1060904@corvil.com>
Date: Tue, 15 Oct 2002 09:48:43 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pranav Desai <prdesai@Bayou.UH.EDU>
CC: linux-kernel@vger.kernel.org
Subject: Re: Booting problem with VIA C3 400A CPU
References: <Pine.OSF.4.44.0210141855070.1234617-100000@bay.uh.edu>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pranav Desai wrote:
> Hi all!
> 	I am not sure if this a bug, but when I try to boot kernel 2.4.18
> it stops just before init starts. It doesnt hang because ctrl+alt+del does
> reboot the system. I tried kernels with 386 and cyrix processors but with
> the same result.

Is your glibc built for 686 (CMOV) ?
Pádraig.

