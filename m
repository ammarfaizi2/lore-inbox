Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267271AbUBNAPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUBNAPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:15:12 -0500
Received: from host207-193-149-62.serverdedicati.aruba.it ([62.149.193.207]:16601
	"EHLO chernobyl.investici.org") by vger.kernel.org with ESMTP
	id S267271AbUBNAPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:15:06 -0500
Subject: get/set MRU on devices other than ppp
From: Alessandro Sappia <a.sappia@ngi.it>
Reply-To: a.sappia@ngi.it
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1076718263.20393.10.camel@galileo.homenet.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 14 Feb 2004 01:24:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to set/get MRU for devices other than ppp?
I mean: I would like to change MRU for my eth0 and similar.
I found ioctls to change MTU, but none for MRU.
I was curious about why this lack ?

Thanks all
Alx

