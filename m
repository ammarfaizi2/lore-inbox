Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWBBQAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWBBQAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWBBQAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:00:51 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:50575 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932091AbWBBQAv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:00:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VdhmE+7Ng7QfauvZfcMqh2FpETRihtRpSRalxrhJ/jc55v3FJ5Ft2QW9Q+JY3pXtADURzRZibtFhUn7pE6l6cMS5WacEJLJNX+EjaHgWnK+zLrwp3hvz6QStfHoe4ARmdZ0NvozBo8JJDUPTNRSQgr4BwqYLGYYuuDAlvA1Rp1Q=
Message-ID: <7f45d9390602020800y1108a12ai832fd0b0ba630d24@mail.gmail.com>
Date: Thu, 2 Feb 2006 09:00:49 -0700
From: Shaun Jackman <sjackman@gmail.com>
Reply-To: Shaun Jackman <sjackman@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: lsserio
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a lsserio utility, akin to lspci and lsusb? In particular,
I'd like to see the result of the PS/2 GETID command for all PS/2
buses and devices.

Cheers,
Shaun
