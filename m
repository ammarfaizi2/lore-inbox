Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270355AbUJTNfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270355AbUJTNfc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270009AbUJTNfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:35:19 -0400
Received: from smtp01.ibpmail.net ([194.151.203.101]:37541 "EHLO
	smtp01.ibpmail.net") by vger.kernel.org with ESMTP id S270355AbUJTNag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:30:36 -0400
Subject: kernel 2.6.9-bk4 make modules error when compile
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF35EC4215.1E87AF6A-ONC1256F33.0049A434-C1256F33.004A1F39@SOPARIND>
From: stephane.purnelle@corman.be
Date: Wed, 20 Oct 2004 15:28:45 +0200
X-MIMETrack: Serialize by Router on BACH/INT/SOPARIND(Release 6.0.3|September 26, 2003) at
 20/10/2004 14:26:01
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi,

I submit this bug report :

On function : <<typhoon_init_one>>
drivers/net/typhoon.c:2479: <<ops>> not declared (first utilisation on this
function).


thank you



