Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWDZNrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWDZNrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWDZNrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:47:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:39465 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932441AbWDZNrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:47:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ruy+9QTMbHNsAUJzo6rKN16Q6fHbOXcOvl1mdRc83+6Jxqt5VuPD6wOfnxRz+08ODv25iBMjo7gX0sVcsmnOw6Q/qDcDnGbJ8mEb0ukM0l1UBcukwC4ldRCl1LRihy16OUqTiC/IKDgiYtUIMllEW6X08tZOz9WIzERZ1k/A5zE=
Message-ID: <4ae3c140604260647q3a69c4e1tebfeea66e193c8a8@mail.gmail.com>
Date: Wed, 26 Apr 2006 09:47:30 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: how to use the new wait functions in wait.c?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like linux kernel switched to new wait function sets in wait.c.
But I cannot find any document about the new APIs. Can someone kindly
let me know where I can find them or let me know how to use them?
Thanks a lot!

xin
