Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTDOOM2 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbTDOOM2 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:12:28 -0400
Received: from vena.lwn.net ([206.168.112.25]:64998 "HELO eklektix.com")
	by vger.kernel.org with SMTP id S261501AbTDOOM0 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:12:26 -0400
Message-ID: <20030415142418.21283.qmail@eklektix.com>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing modules for 2.5 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "15 Apr 2003 13:15:17 +0200."
             <yw1x7k9w9flm.fsf@zaphod.guide> 
Date: Tue, 15 Apr 2003 08:24:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What magic needs to be done when writing modules for linux 2.5.x?

May I humbly suggest LWN's "porting drivers to 2.5" series?

	http://lwn.net/Articles/driver-porting

There's 20-some articles there now on various API changes in the 2.5
kernel.  The series is getting reasonably complete at this point; hopefully
it will be helpful.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
