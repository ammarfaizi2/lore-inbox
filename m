Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWBFLqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWBFLqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWBFLqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:46:32 -0500
Received: from main.gmane.org ([80.91.229.2]:42411 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750947AbWBFLqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:46:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Neal Becker <ndbecker2@gmail.com>
Subject: 2.6.12-rc1 panic on startup (acpi_
Date: Mon, 06 Feb 2006 06:46:12 -0500
Message-ID: <ds7cu3$9c0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: nat-expu-252-168.hns.com
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP dv8000 notebook
2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup

Here is a picture of some traceback
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view

