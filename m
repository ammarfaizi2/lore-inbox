Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTFXRsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTFXRsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:48:18 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:43783 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262390AbTFXRsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:48:16 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200306241802.OAA26518@clem.clem-digital.net>
Subject: 2.5.73 -- Uninitialised timer! (i386)
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Tue, 24 Jun 2003 14:02:24 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

With 2.5.73 (i386) have picked up an 'Uninitialised timer!'
message with associated 'Call Trace:'. Only see this on
systems complied as UP.  
-- 
Pete Clements 
clem@clem.clem-digital.net
