Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTELRfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTELRfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:35:04 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50328
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262362AbTELRfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:35:03 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305121234_MC3-1-3882-CFEC@compuserve.com>
References: <200305121234_MC3-1-3882-CFEC@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052758008.31824.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 17:46:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 17:32, Chuck Ebbert wrote:
>   So how long till Linux gets decent auditing?  Is the SNARE code going
> to get into the kernel?

Its on the todo list. I had some discussion with the snare guys and Al
Viro educated them on some of the name logging issues

>   ...and on a related topic, if someone wrote a patch to optionally clear
> the swap area at swapoff would it ever be accepted?

man dd ?

although I'm not sure what good it would do you, you want crypted swap


