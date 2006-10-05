Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWJENIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWJENIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWJENIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:08:21 -0400
Received: from srvh02.vc-server.de ([83.246.78.195]:57566 "EHLO
	srvh02.vc-server.de") by vger.kernel.org with ESMTP
	id S1751181AbWJENIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:08:21 -0400
Date: Thu, 5 Oct 2006 15:08:16 +0200
From: Dennis Heuer <dh@triple-media.com>
To: linux-kernel@vger.kernel.org
Subject: sunifdef instead of unifdef
Message-Id: <20061005150816.76ca18c2.dh@triple-media.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srvh02.vc-server.de
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - triple-media.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

unifdef is not only very old and unmaintained, the binary does not work
and the source does not compile on a pure x86_64 system. There is
another tool that worked for me--though it 'closed with remarks'--and
that was updated recently (several times this year). It is called
sunifdef, is under an equal (new) BSD license, and is proposed to be
the successor of unifdef. See the project page:

http://www.sunifdef.strudl.org/

Regards,
Dennis
