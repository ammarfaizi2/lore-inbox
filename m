Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVBXFEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVBXFEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVBXFEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:04:00 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:13670 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261826AbVBXFDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 00:03:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=N0AOQ1WERrNDHyQH6uJEjCmQ5VxgLQWzH5dnPIttNjm9GeA3s3ZxO46wK3qbfCw2T04ysGIqu0OYn/GKfd5WQMwBG4L/Z3l9fjwUjUrsqQ7swe8lca8oI3r1f9CAQM2w089dDX2CqtS4iS+iPz+hyBVYaH364jT/5GQGSTV6v7w=
Message-ID: <d3a6bba0050223210312d93aee@mail.gmail.com>
Date: Wed, 23 Feb 2005 21:03:24 -0800
From: Anil Kumar <anilsr@gmail.com>
Reply-To: Anil Kumar <anilsr@gmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: module insert question
Cc: anilsr@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you please let me know, what all files does the OS look into to
load modules?
I see the following messages during boot rather installation:
======
Finished bus probing
modules to insert tg3 aic79xx
======

which files does the OS look into to load tg3 and aic79xx after
finishing bus probing. I guess modprobe.conf, modules.alias,
modules.pcimap.

with regards,
    Anil
