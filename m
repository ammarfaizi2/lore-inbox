Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbTGUG0l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 02:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbTGUG0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 02:26:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50917
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269266AbTGUG0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 02:26:40 -0400
Subject: Re: [Fwd: Re: Kernel 2.4 CPU Arch issues]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "William M. Quarles" <quarlewm@jmu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1B32E6.4020107@jmu.edu>
References: <3F1B25C2.8010403@jmu.edu>
	 <1058745605.6299.4.camel@dhcp22.swansea.linux.org.uk>
	 <3F1B32E6.4020107@jmu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058769556.6977.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jul 2003 07:39:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-21 at 01:25, William M. Quarles wrote:
> Well, wouldn't changing the gcc -march option and/or adding -mcpu 
> options for the various processors in the Makefile make a difference, as 
> the patchfile suggests?

Currently - no. gcc knows a lot more processor names that require individual
unique optimisation

