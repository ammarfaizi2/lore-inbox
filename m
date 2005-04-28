Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVD1XwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVD1XwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVD1XwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:52:24 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:30302 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262321AbVD1XwV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:52:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aZBnJXPTcltCVBFfJDQZjsMTSUf1+DOBNlfbXo8Nv5Nh0WhdWfQrIxTm6/KmT/8TakGF3SENSIJsjnMstB2bs4ANK1H1CWZYgrPlqqaQ3GCPcevhqy47g0V29Djgy69hU3vpcLf0IVXfnjU7GfjHxJc7gEv8m/eaWu6fxTcdydo=
Message-ID: <ba83582205042816522e2a7a93@mail.gmail.com>
Date: Thu, 28 Apr 2005 16:52:21 -0700
From: Gilles Pokam <gpokam@gmail.com>
Reply-To: Gilles Pokam <gpokam@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel memory
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure this is the right place to post my message, but I do need
some advice for my problem.

I have a special user application who needs to access any part of the
kernel memory. My question is therefore how to make the whole memory
accessible for that particular application ?

Thanks.
