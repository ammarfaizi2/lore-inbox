Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262491AbSJKPJo>; Fri, 11 Oct 2002 11:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262497AbSJKPJo>; Fri, 11 Oct 2002 11:09:44 -0400
Received: from vena.lwn.net ([206.168.112.25]:47111 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S262491AbSJKPJo>;
	Fri, 11 Oct 2002 11:09:44 -0400
Message-ID: <20021011151531.3430.qmail@eklektix.com>
To: Thierry Mallard <thierry.mallard@vawis.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: schedule_task still available in 2.5.41 ? (working on nvidia kernel module driver, but maybe not related) 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 11 Oct 2002 17:05:05 +0200."
             <20021011150505.GA1684@d133.dhcp212-198-6.noos.fr> 
Date: Fri, 11 Oct 2002 09:15:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

schedule_task is, as they say, an ex-parrot.  See:

	http://lwn.net/Articles/10963/

(now available without subscription :) for a description of the change,
and, even, some documentation of the new workqueue interface.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
