Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWAREw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWAREw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 23:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWAREw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 23:52:56 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:10738 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964937AbWAREwz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 23:52:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DlYSHtspOHBBq4VUlzxtYdvHAYsfTUP/OqgMzb1fvCBoPea3Q2IMPInH92k87rUGqy/BZM2pAM8RTQsGHdO8INqNwXU582iXJsdl8rRK7B9+kMDz5CjxeoytMxrWYcv0LbzkTIwadHP0uGI/xTr1lF42uXv8NImpRgUccCkduiE=
Message-ID: <993d182d0601172052j34daab5bj9bab14178a6b1742@mail.gmail.com>
Date: Wed, 18 Jan 2006 10:22:54 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NFS problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
i am having some problem in having root file system on NFS,
i am developing a linux embedded system,. when i have a root file
system on a NFS and i try to boot the kernel through a repeater hub ,
then the kernel hangs at freeing init memory.

 if i connect the board with the PC through a cross cable,
then the system works ok.

does anybody has some idea about it
