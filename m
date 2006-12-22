Return-Path: <linux-kernel-owner+w=401wt.eu-S1423099AbWLVOrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423099AbWLVOrP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423107AbWLVOrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:47:15 -0500
Received: from www17.your-server.de ([213.133.104.17]:1818 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423099AbWLVOrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:47:14 -0500
Message-ID: <458BEB9D.8030709@m3y3r.de>
Date: Fri, 22 Dec 2006 15:28:45 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061126)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again current git head:

I guess this should be fixed by someone!

WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!
make[1]: *** [__modpost] Fehler 1
make: *** [modules] Fehler 2

