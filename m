Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbUKDGCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbUKDGCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbUKDGCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:02:31 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:8070 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262078AbUKDGC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:02:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=lO1V+m3ksEdfncujCOaDWo8ZJQE5/AcVCgC84gmILtZZe9hz6NfEbvK1Oz3UUIfF7Z/482vV00hvwRjl/odScWfAyGeyvFKo1iYnQj5p+WETtxK/QSxkIOKjfQ38gcHPSSMmTcjq8ALGIycQgtIzErMSmIbtJkb67cwjLJLDw1A=
Message-ID: <19f134cc04110322027fb6f124@mail.gmail.com>
Date: Thu, 4 Nov 2004 11:32:25 +0530
From: Pradeep Anbumani <pradeepdreams@gmail.com>
Reply-To: Pradeep Anbumani <pradeepdreams@gmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Acknowledgement flooding for a packet received....
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guyz,

 I need to repeat sending the same acknowledgement received, for a
packet received, after the completion of the three way handshake how
should I proceed or what function should I go through to do this. I
already went through the "tcp_send_ack" function but this function is
being called for Initial 3 way hand shake also.....please do help me
out.

thanx in advance,
regards,
Pradeep
