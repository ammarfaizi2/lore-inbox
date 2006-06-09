Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbWFIQlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbWFIQlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWFIQlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:41:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:13109 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965283AbWFIQlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:41:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:cc:message-id:date:from;
        b=LSrG9c5gq/S802btxXWbTX2wX9/ymg98yzi7POT8TtpA+eaIMesp8BNM9RZJDahCLbaEcRmYCHaIIM3LesuPmWiF3at70GI5UPr/t7wx5VDGCIS2EfwWr9Md8HGpSN0lSCc/quFAokI173P/5DXuzntRMIiUJkAwPczuBhH7jL8=
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] vfs: support for COW files in sys_open: resend
Cc: cspalletta@gmail.com, viro@zeniv.linux.org.uk
Message-Id: <20060609165211.AD6E6118601@localhost.localdomain>
Date: Fri,  9 Jun 2006 12:52:11 -0400 (EDT)
From: carl <cspalletta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consolidate patches and resend without unintended HTML formatting
