Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264304AbUFKSwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbUFKSwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUFKSwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 14:52:36 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:52654 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S264304AbUFKSwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 14:52:36 -0400
Date: Fri, 11 Jun 2004 13:51:56 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: TCP NFS to Novell does not work
Message-ID: <20040611185156.GA26757@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using kernel 2.4.26, I am unable to copy large files to novell over TCP
NFS.  It copies part of the file, the I get a "stale NFS file handle" error. 
I can then delete the file on novell over NFS without a problem.  I do not
have this problem coping to a tru64 mount.

UDP works, but I get corruption in the file.  Which I shouldn't get.

Andy
