Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTJFSjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbTJFSjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:39:20 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:63486 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262714AbTJFSjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:39:17 -0400
Subject: Re: s390 test6 patches: descriptions.
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF920AD7A2.92783074-ONC1256DB7.0066393E-C1256DB7.00666957@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 6 Oct 2003 20:38:36 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 20:39:07
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> the default target seems to be broken. The old way
> ("make image modules") works fine. Not that I care too much,
> but I got some grief in sparc about it. FYI.

Just "make" works fine for me. And there isn't another patch
in the pipe for the s390 Makefiles. In my Makefiles there isn't
a "listing" target anymore.

blue skies,
   Martin


