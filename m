Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVKLUoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVKLUoh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVKLUog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:44:36 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:24909 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964794AbVKLUog convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:44:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nNnFC6rS5UwSM8U++2/ZXsMlNrX2+5/LCM0qe8irBTFA9u+jZiA0DyiP3uzMZi91Qmrg0T+ZyDdiaok2Cy//tmyY2hUATfrRz29R/am4DHSUo/SxuuFQX8FWVTIyqqVDaHi8hqVgymXi/2yVs6ASovjt7FWLQ266JgPpn+jjcAg=
Message-ID: <4ae3c140511121244v3cfdb3c6v133d67d8fa42c46b@mail.gmail.com>
Date: Sat, 12 Nov 2005 15:44:35 -0500
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NFS question: what's the use of nfs3_async_handle_jukebox?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am reading the NFS codes, but got stuck at the
nfs3_async_handle_jukebox() function. What's the use of this function?
IS there any document about this? Thanks!

-x
