Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSJCWkT>; Thu, 3 Oct 2002 18:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSJCWjp>; Thu, 3 Oct 2002 18:39:45 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:58558 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261413AbSJCWjD>; Thu, 3 Oct 2002 18:39:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: linux-kernel@vger.kernel.org
Subject: [PATCH] EVMS core 1/4: evms.c
Date: Thu, 3 Oct 2002 17:11:52 -0500
X-Mailer: KMail [version 1.2]
References: <02100307355501.05904@boiler>
In-Reply-To: <02100307355501.05904@boiler>
MIME-Version: 1.0
Message-Id: <02100317115209.05904@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried twice to send the first part of this patch, but it does not seem 
to have gone through. I'm guessing it's stuck on a mail filter somewhere. For 
the time being, please see:

http://marc.theaimsgroup.com/?l=evms-devel&m=103365150530085&w=2

for the contents of evms.c.

On Thursday 03 October 2002 07:35, Kevin Corry wrote:
> Greetings,
>
> Here is part 1 of the EVMS core. This provides the plugin framework and
> common services.
>
> Kevin Corry
> corryk@us.ibm.com
> http://evms.sourceforge.net/
