Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272224AbTHRR5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272225AbTHRR5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:57:35 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:31119 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S272224AbTHRR5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:57:35 -0400
Date: Mon, 18 Aug 2003 19:56:52 +0200
From: Alessandro Salvatori <a.salvatori@universitari.crocetta.org>
To: linux-kernel@vger.kernel.org
Subject: cannot stat hidden windows files in a cdrom...
Message-Id: <20030818195652.212ec7dd.a.salvatori@universitari.crocetta.org>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if a cdrom burnt under windows contains hidden files you cannot see and/or read them from linux. while you can see hidden files in mounted windows filesystems. This happens with any Linux kernel and i have no idea how windows does burn these hidden files on cdroms and wether or not it would be good for Linux to read them, anyway there is a "Microsoft Joliet CDROM extensions" voice that claims to let you read Joliet cdroms and maybe you would like these file to be read too.
cheers
sandr8
