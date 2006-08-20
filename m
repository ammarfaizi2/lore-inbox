Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWHTRqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWHTRqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWHTRqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:46:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:60142 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751058AbWHTRqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:46:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d2+ooXXk9nfO828cOtIwK6CK2ZmhctUNLXQHFwl94H6yunFCkTVLX/zU+cX84hbwifPbmH2+1m+ppT7AmrSTeUwBSfdnnM3EVAg8m6BhG+ohTKUCwPzajR2mGbyyQyXvL03B/bEG3U7aLo250Q5ItuG9pck4W0mZAEZrBPfpIa4=
Message-ID: <3420082f0608201046q53bb60b5u5ca8915e588ee9e3@mail.gmail.com>
Date: Sun, 20 Aug 2006 22:46:14 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: question on pthreads
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Where should I look for the code of the native Pthreads implemetation:

I've found this:
http://pauillac.inria.fr/~xleroy/linuxthreads/

Supposedly from the site,it has been superceeded by NPTL by Ulrich
Drepper, but I cant find the code for NPTL?
