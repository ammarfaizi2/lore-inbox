Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWAFVKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWAFVKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWAFVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:10:16 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:7246 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932455AbWAFVKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:10:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S+nh19bQQV9cNl1sKbREPOZVwzH3zFhAHr5n6+p7b2OiM28fBCP3nxi9opUR8bToNv1jBkozjmaxUM+n9xf8kvyd+pw9i5nzkgwCg9CcMPxBc2ntRenQOgMVivlCpO/EMlRLYfgWKAh2mvBRxd5Yvpvjz2zXAFUiEdVUhITWt9g=
Message-ID: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
Date: Fri, 6 Jan 2006 22:10:13 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===========
Userspace-driven configuration filesystem (EXPERIMENTAL) (CONFIGFS_FS)
[M/y/?] (NEW)

Both sysfs and configfs can and should exist together on the
same system. One is not a replacement for the other.

If unsure, say N.
===========

I think I'll say M - for now ;)

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
