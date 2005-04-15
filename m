Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVDOST1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVDOST1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVDOSSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:18:33 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:8266 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261899AbVDOSPk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:15:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=F7dMhGSXsQ328Yw3juNcg6izsw2kq5B95eOAJkWgSA3WM47+4VuHVnW1tf7HFjShkLCuECYldypfBj5qL5/KxRfoLd9HAJrHT7EPeC5pu+YstHIXYW3yn9r5gpW1yySPEfwBtq9LTGQVDUUk0qgsJHmMCHBd6wgQ+XZ/Wykmk0Y=
Message-ID: <17d79880504151115744c47bd@mail.gmail.com>
Date: Fri, 15 Apr 2005 18:15:37 +0000
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Rootkits
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I got the terminology mixed up. I guess what I really want to know is,
what are the different types of exploits by which rootkits
(specifically the ones that modify the kernel) can get installed on
your system.(other than buffer overflow and somebody stealing the root
password)

I know that SucKIT is a rootkit that gets loaded as a kernel module
and adds new system calls. Some other rootkits change machine
instructions in several kernel functions.

Once these are loaded into the kernel, is there no way the kernel
functions can be protected ?

thanks,
Allison
