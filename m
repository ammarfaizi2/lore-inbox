Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbTHSXZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTHSXZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:25:11 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:3739
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261341AbTHSXZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:25:09 -0400
Date: Tue, 19 Aug 2003 19:34:56 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: DVD ROM on 2.6
Message-ID: <20030819193456.B25148@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying out 2.6 on one of my test boxes with an IDE dvd drive.  I'm using
ide-scsi (I prefer scdx as opposed to hdx).  I noticed that any attempt to
mount a DVD movie (lord of the rings comes to mind) it mounts as UDF.  My
laptop mounts this same dvd as iso9660.

I've also been unable to play DVDs on this machine, but I don't have the
same packages installed as I do on my laptop.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
