Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUELUDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUELUDZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbUELUDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:03:25 -0400
Received: from 213-0-215-121.dialup.nuria.telefonica-data.net ([213.0.215.121]:3204
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S265207AbUELUDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:03:23 -0400
Date: Wed, 12 May 2004 22:03:22 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 breaks VMware compile..
Message-ID: <20040512200322.GA4947@localhost>
Mail-Followup-To: John Covici <covici@ccs.covici.com>,
	linux-kernel@vger.kernel.org
References: <407CF31D.8000101@rgadsdon2.giointernet.co.uk> <m365b15vls.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m365b15vls.fsf@ccs.covici.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 12 May 2004, at 14:49:35 -0400,
John Covici wrote:

> How do Iget that patch since its still broke in 2.6.6?
> 
Maybe you forgot to "apply" the "patch" to VMware to allow it to compile
its interface and run OK in newer kernels. Check:
ftp://platan.vc.cvut.cz/pub/vmware

for the latest version of the "patch" (vmware-any-any-update66.tar.gz).

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.6)
