Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWBEKE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWBEKE0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 05:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWBEKE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 05:04:26 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:47791 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751703AbWBEKE0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 05:04:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=thb+Cf8+Qk5E0R9pDv6aLSi5cL6/APbKT0IHfY9gcYlunAVnQA9kA19TDF1ejoFzEOPYY139A18eKOPUbiYF/NGz8I/zX9I4pmJTeIDemodK0EBfsiEyHdQ17Lruz+F8/zAZi+wjG20HsTdC8dIM2rwKYpMCeAqaLWQMv2f8wGM=
Message-ID: <b92f4fd10602050204g41f70f70p@mail.gmail.com>
Date: Sun, 5 Feb 2006 11:04:25 +0100
From: =?ISO-8859-2?Q?Pawe=B3_Zadr=B1g?= <p.zeddi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to tune kernel to swap more often (video ram swap)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo...

In normal case, using harddisk as a swap space i should ask how to cut
down swapping, or make swapping when idle, etc... My case is a little
bit diffrent... I have a 256MB video card, while 240MB of it is used
as a swap space. And the question is: how to tune kernel to swap more
often. I known swapped memory must be copied back to ram before beeing
used, so i'm looking for a reasonable tunning values...

What do You think about that mighty list ?

--
Chears,
zeddi
