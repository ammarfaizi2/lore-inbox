Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUDAIU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUDAIU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:20:58 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:28875 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S261467AbUDAIU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:20:57 -0500
Date: Thu, 1 Apr 2004 10:20:53 +0200 (CEST)
From: Soeren Noehr Christensen <snc@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Subject: Getting a dentry from an inode.
Message-ID: <Pine.LNX.4.56.0404011016490.10829@homer.cs.auc.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on a securityproject (umbrella.sourceforge.net), we need to
access the dentry struct(s) associated with a particular inode, and all we
have access to is the inode struct. Does anyone know how to do get the
dentry structs from this?

Thanks,

//snc
