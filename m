Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbTJNRB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 13:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTJNRB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 13:01:29 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:20742 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262304AbTJNRB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 13:01:28 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "Grover, Andrew" <andrew.grover@intel.com>, <earny@net4u.de>
Subject: Re: ACPI in -pre7 builds with -Os
Date: Tue, 14 Oct 2003 18:57:07 +0200
User-Agent: KMail/1.5.3
References: <F760B14C9561B941B89469F59BA3A84702C93046@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84702C93046@orsmsx401.jf.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310141857.07774.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 October 2003 18:50, Grover, Andrew wrote:

Hi Andrew,

> > Looks like a bug. And a missing feature.
> > - ACPI_CFLAGS := -Os
> > + ACPI_CFLAGS := -Os --bzip2

> What does that do, excatly? (Obviously compression-related...) I
> couldn't find it in the gcc 3.2.2 documentation, is it new?

rotfl. I think it was meant as a joke ;)

ciao, Marc


