Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUFRM3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUFRM3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 08:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUFRM3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 08:29:41 -0400
Received: from linux2.isphuset.no ([213.236.237.186]:21226 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S265130AbUFRM3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 08:29:38 -0400
Subject: Re: ACPI / cpu temperature problem
From: Hans Kristian Rosbach <hans.kristian@isphuset.no>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1086783539.14784.24.camel@linux.local>
References: <1086783539.14784.24.camel@linux.local>
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1087561770.8257.6.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 14:29:31 +0200
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hans.kristian@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, the problem with all these supermicro servers is that the
> temperature seems to be stuck at 27 C. No matter what load or
> temperature in the room. Something is clearly wrong.
> What can be done to fix this? We tried setting polling_frequency
> to '10', but that made no difference.

I reported this to the kernel bug tracker, but there seems to be
no forward movement at all. So I'll try here again in the hope that
someone that know this code atleast has a comment to it.

http://bugme.osdl.org/show_bug.cgi?id=2855

Sincerly
   Hans K. Rosbach


