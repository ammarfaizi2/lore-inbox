Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271858AbTGRVnx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTGRVm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:42:27 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48855
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270379AbTGRVlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:41:50 -0400
Subject: Re: [PATCH] docbook: Added support for generating man files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Still <mikal@stillhq.com>
In-Reply-To: <20030718212350.GA5733@mars.ravnborg.org>
References: <20030718204852.GA4443@mars.ravnborg.org>
	 <20030718212350.GA5733@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058565240.19558.91.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 22:54:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 22:23, Sam Ravnborg wrote:
> Hi Linus - please apply. Only docbook relevant changes [with patch this time].
> 
> Originally by Michael Still <mikal@stillhq.com>
>  
> This patch adds two new targets to the docbook makefile -- mandocs, and

IS there any chance it could incorporate the GPL by a slightly smaller
reference or even a link for the HTML one, it looks great except that
90% of the manual page is a GPL each time 8)


