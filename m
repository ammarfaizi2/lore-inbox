Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVLAO2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVLAO2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLAO2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:28:16 -0500
Received: from mail0.lsil.com ([147.145.40.20]:27813 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932243AbVLAO2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:28:16 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662C65@exa-atlanta>
From: "Ju, Seokmann" <Seokmann.Ju@engenio.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: How to setup git 
Date: Thu, 1 Dec 2005 09:28:12 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use git and in the middle of installing it on the RHEL4 U2.
I have following modules in hand.
- git-core-0.99.7-1.i386.rpm
- cogito-0.15.1-1.noarch.rpm

During 'git-core-0.99.7-1.i386.rpm' installation, I'm getting following
error message,
[root@dhcp root]# rpm-ihv git-core-0.99.7-1.i386.rpm
error: Failed dependencies:
	perl(String::ShellQuote) is needed by git-core-0.99.7-1.i386
	python >= 2.4 is needed by git-core-0.99.7-1.i386

Where can I find those modules?
Also, please point out if you see any further obstacles along the way to
move forward.

Any feedback would be appreciated.

Regards,

Seokmann
