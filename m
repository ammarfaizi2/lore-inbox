Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTEBOe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbTEBOe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 10:34:56 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:60074 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S262371AbTEBOez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 10:34:55 -0400
Subject: Re: 2.5.68-mm4
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030502020149.1ec3e54f.akpm@digeo.com>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051886748.2166.20.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 02 May 2003 08:45:48 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-02 at 03:01, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.68/2.5.68-mm4/
> 
> . Much reworking of the disk IO scheduler patches due to the updated
>   dynamic-disk-request-allocation patch.  No real functional changes here.
> 
> . Included the `kexec' patch - load Linux from Linux.  Various people want
>   this for various reasons.  I like the idea of going from a login prompt to
>   "Calibrating delay loop" in 0.5 seconds.
> 
>   I tried it on four machines and it worked with small glitches on three of
>   them, and wedged up the fourth.  So if it is to proceed this code needs
>   help with testing and careful bug reporting please.
> 
>   There's a femto-HOWTO in the patch itself, reproduced here:
> 
> 
> 
> - enable kexec in config, build, install.
> 
> - grab kexec-tools from
> 
> 	http://www.osdl.org/archive/andyp/kexec/2.5.68/
> 
The andyp directory seems to be missing.  I found kexec-tools-1.8 here:
http://www.xmission.com/~ebiederm/files/kexec/

Is that the latest version?

Steven

