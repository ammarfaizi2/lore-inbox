Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267781AbUHPPl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267781AbUHPPl3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267788AbUHPPkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:40:46 -0400
Received: from vsmtp4alice-fr.tin.it ([212.216.176.150]:10968 "EHLO
	vsmtp4.tin.it") by vger.kernel.org with ESMTP id S267781AbUHPPdK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:33:10 -0400
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
From: Giacomo Perale <g.perale@tin.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1092670389.8716.2.camel@KazeNoTani>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 17:33:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cdrecord 2.00.3 seems to work flawlessy even if it isn't set suid, but
everyone I know noticed the problem with cdrecord 2.01alphaXX (checked
with alpha28, alpha33 and alpha36).

