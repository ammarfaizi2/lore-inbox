Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272063AbTG3NmC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272857AbTG3NmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:42:02 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:50570
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S272063AbTG3NmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:42:01 -0400
Date: Wed, 30 Jul 2003 09:57:43 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 knfsd
Message-ID: <20030730095743.A15543@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not working for me.  Client is 2.4.20 with nfsv3 enabled.  I enabled
nfsv3 but not nfsv4 on the server.  Client mounts, but when I attempte to
get a directory, the process on client goes D state.

Export on server was:
/ vegeta(rw,no_root_squash,async,nohide)

this name is resolvable on the server as 192.168.2.7

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
