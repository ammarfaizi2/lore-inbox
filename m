Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWEOOCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWEOOCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWEOOCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:02:00 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:10723 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964922AbWEOOB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:01:59 -0400
Subject: Re: GPL and NON GPL version modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Nutan C." <nutanc@esntechnologies.co.in>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, greg@kroah.com, Shakthi Kannan <cyborg4k@yahoo.com>
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
References: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 15:14:33 +0100
Message-Id: <1147702473.26686.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 15:23 +0530, Srinivas G. wrote:
> Dear All,
>  
> I have a small doubt about the GPL and NON GPL version modules.
> 
> If I have a module called module A which uses the GPL code and module B
> uses the NON GPL (proprietary) code. If the module A depends on module
> B, is it possible to load these modules? That is some of the functions
> (which are defined in module B) are called from module A.
> 
> Will it be violating any GPL Rules?

Probably. Ask your company lawyer to advise you on the subject of
"derivative works". 

Alan

