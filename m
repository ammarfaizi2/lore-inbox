Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265449AbTFVC1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 22:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbTFVC1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 22:27:36 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:19842 "EHLO
	firewall.ocs.com.au") by vger.kernel.org with ESMTP id S265449AbTFVC1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 22:27:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: kdb v4.3 is available for kernels 2.4.20, 2.4.21 
In-reply-to: Your message of "Sat, 21 Jun 2003 11:22:00 MST."
             <1056219720.21882.87.camel@biznatch> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Jun 2003 12:41:31 +1000
Message-ID: <31941.1056249691@firewall.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003 11:22:00 -0700, 
Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu> wrote:
>2003-06-21 Tom Duffy <Thomas.Duffy.99@alumni.brown.edu>
>
>        * got rid of kdb_eframe_t per Keith's request
>        * fixed double printing on kdb command line
>        * kdb v4.3-2.4.21-sparc64-2
>
>can be found on:
>
>http://www.dslextreme.com/users/tomduffy/kdb-v4.3-2.4.21-sparc64-2.bz2

With a couple of minor changes, uploaded to
ftp://oss.sgi.com/projects/kdb/download/v4.3/kdb-v4.3-2.4.21-sparc64-3.bz2

+       * Leave tab character alone.  Keith Owens.
+       * Tweak KDB_ENTER.  Keith Owens.
+       * kdb v4.3-2.4.21-sparc64-3

