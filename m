Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbUJaQVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUJaQVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 11:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUJaQVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 11:21:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50639 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261247AbUJaQVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 11:21:45 -0500
Date: Sun, 31 Oct 2004 17:21:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Pipe sizes
Message-ID: <Pine.LNX.4.53.0410311719090.20529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have a patch that returns the pipe's fill status when stat(), rather than
just returning 0. It's just a cosmetical thing, but would anyone like to have
it too?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
