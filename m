Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVJGFWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVJGFWR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 01:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVJGFWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 01:22:17 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:12765 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932233AbVJGFWR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 01:22:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BR0IWIHK/1Yh/Sts9GNPbDVmCQfUmCp5i7GaXdzXVbrK2PW4iBFt3VdNxDsnePANi1RWE92+df4JgAhOm92vCUNs2V87/XznXq27QgrPG/1VCSVmqmfRPe3vJ8tDDfXZ2NxHEH4bNnkR2Mq9Z5AMqngrsdIY0RcDrEB5ON30p+0=
Message-ID: <4ae3c140510062222r3324c35cpba250612bad48dad@mail.gmail.com>
Date: Fri, 7 Oct 2005 01:22:16 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: how to search file data blocks in kernel 2.6?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.4, we have structures like clean_pages to organize various cached
file data. But in 2.6, these structures disappeared. So how to
determine whether a file data block exists in cache? Can someone
kindly give me a brief description and point me to the right function
or linux source code file? Many thanks!

-x
