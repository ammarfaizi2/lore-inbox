Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVCGOAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVCGOAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 09:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVCGOAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 09:00:12 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:2521 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261177AbVCGOAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 09:00:08 -0500
MIME-Version: 1.0
Date: Mon,  7 Mar 2005 15:00:04 +0100
To: linux-kernel@vger.kernel.org
X-UMS: email
X-Mailer: TOI Kommunikationscenter V5-0PL2
Subject: Error message during boot: module ide-detect not found
From: "RG.Schneider@t-online.de" <RG.Schneider@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1D8ImC-2I5bqS0@cmpmail05.bbul.t-online.de>
X-ID: ZqKr9mZYYe3FyxSGWnDpuVbd3Kw-x5M7Z9MzKs35G4f2f8ZicqsnEW@t-dialin.net
X-TOI-MSGID: 35218dde-2680-469f-a1c8-7b301c70c4f9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
when booting a 2.6 kernel of a Debian distribution (Sarge) I always get
the above error message. Additionally, the ide chipset is
not detected and hard disc and ide - cdrom drives are not available.

In '/etc/modules' , 'ide-detect' is listed. When I change this to
'ide-generic', everything is fine.

This might be a problem of Debian distribution ( Sarge ) or more general
??

/RalfS


