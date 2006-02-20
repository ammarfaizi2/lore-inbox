Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWBTHsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWBTHsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 02:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWBTHsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 02:48:09 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:36739 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932692AbWBTHsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 02:48:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=trO2QWZn/mGLP0Ve7Pe7LT4ikDdvMfvQiYEtr+r/O3hTtOhKh404QoQuuHgSNpGfvLHtM6+NmP2XTW+fMAe0Fx7dkpbX8YohacoQQQM+8TBAJ9N7uMQp61/uDTfD1b7ndlOTbasNUN0V2rR/5qboIaalcujFjZJRaWU9EeMqz1c=
Message-ID: <5f1573750602192348s46021c2ci51931b51c90e50ed@mail.gmail.com>
Date: Mon, 20 Feb 2006 12:48:07 +0500
From: "Sana Khawaja" <sanakhawaja@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: deadlock etection
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can someone please shed somelight on how the LINUX kernel version 2.4
detects and then removes the processes in deadlock.


Sana Naveed Khawaja
